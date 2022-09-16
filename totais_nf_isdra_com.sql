select 
/* ###### OK ###### */ SUM(n.VALOR_LIQUIDO -n.VLR_DIFAL) as "Mercadorias R$",
SUM(ROUND((case 
	when AP.PRODUTOS in('Acessórios', 'Telhas') 
then (n.PESO_ITEM/1000)
	when AP.PRODUTOS in('Recortes') 
	and n.COD_FISCAL not in ('5910','6910','6151','5116','6116')
then (n.PESO_ITEM/1000) else (n.PESO_ITEM/1000) end ),2)) as "Ton",
SUM(case when n.PESO_ITEM <> 0 then (n.VALOR_LIQUIDO -n.VLR_DIFAL)/ n.PESO_ITEM else (n.VALOR_LIQUIDO -n.VLR_DIFAL)/1 end) as "PM (em Ton)",
/* ###### OK ###### */ SUM(n.VALOR_BRUTO)  as "Fat. Bruto",
/* ###### OK ###### */ SUM(n.VLR_APUR_PIS)+SUM(n.VLR_APUR_COFINS)+SUM(n.VLR_ICMS)+SUM(n.VLR_ICMS_SOL)+SUM(n.VLR_IPI) as "Impostos",
/* ###### OK ###### */ (SUM(n.VLR_APUR_PIS)+SUM(n.VLR_APUR_COFINS)+SUM(n.VLR_ICMS)+SUM(n.VLR_ICMS_SOL)+SUM(n.VLR_IPI))/(SUM(n.VALOR_BRUTO)+sum(n.VLR_ICMS_SOL))*100 as "% Impostos",
/* ###### OK ###### */ ROUND(SUM(n.VLR_COMIS_ITEM ),2) as "Comissão",
/* ###### OK ###### */ round(((SUM(n.VLR_COMIS_ITEM )/(sum(n.VALOR_TOTAL)+sum(n.VLR_ICMS_SOL)+sum(n.VLR_IPI)))*100),2)  as "% Comissão",
/* ###### OK ###### */ round(SUM(n.TX_FINANCEIRA),2)  as "Tx. Financeiras",
/* ###### OK ###### */ round((SUM(n.TX_FINANCEIRA) / (SUM(n.VALOR_TOTAL)  + SUM(n.VLR_ICMS_SOL) + SUM(n.VLR_IPI))*100),2) as "% Tx. Fin.",
/* ###### OK ###### */ round(SUM(n.VALOR_DECONTO_COMERCIAL_ITEMNF),2)  as "R$ Desc. Com.",
/* ###### OK ###### */ round((SUM(n.VALOR_DECONTO_COMERCIAL_ITEMNF) / (SUM(n.VALOR_TOTAL)  + SUM(n.VLR_ICMS_SOL) + SUM(n.VLR_IPI))*100),2) as "% Desc. Com."
from NFSAIDA n 
left join PRODUTOS p 
on p.CODIGO_PRODUTO = n.CODIGO_PRODUTO 
left join TES t  
on t.CHAVE_TES = n.CHAVE_TES 
left join CLIENTES c 
on replace(n.LOJA, ' ','')  = replace(c.LOJA, ' ','')
and replace(n.CLIENTE, ' ','')  = replace(c.CLIENTE, ' ','')
and c.CLIENTE_DELETADO <> '*'
left join VENDEDORES v 
on v.CODIGO_VENDEDOR = n.VENDEDOR1 
left join CONDICAO_PGTO cp 
on cp.COND_PGTO = n.CONDPAGTO
left join TIPOCLIENTE t2 
on t2.CHAVE = c.GRPCLIENTES
inner join DW.AGRUPADOR_PRODUTO AP on
AP.COD_GRUPOPRODUTO = n.COD_GRUPOPRODUTO
WHERE
AP.PRODUTOS in('Acessórios', 'Recortes', 'Telhas')
and n.FILIAL in ('02', '03')
and t.GERA_DUPLICATA = 'S'
order by n.DT_EMISSAO desc;

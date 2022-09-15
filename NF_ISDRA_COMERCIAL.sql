select 
t2.DESCRICAO  as "Tipo Cliente",
c.NOME  as "NOME CLIENTE",
n.NUMERO_NF  as "Numero NF",
c.ESTADO  as "UF",
to_char(n.DT_EMISSAO, 'mm/yyyy')  as "Período",  ---------------------------???
to_char(n.DT_EMISSAO, 'mm/yyyy') as "Emissao Pedido", ---------------------------???
n.FILIAL  as "Filial",
' '  as "GRUPO", ---------------------------???
cp.DESC_COND_PGTO  as "Cond. Pag",
AP.DESC_GRUPO  as "Grupo de Produto",
' '  as "Dimensão", ---------------------------???
p.DESCRICAO  as "Descricao do Produto",
c.MUNICIPIO  as "Municipio",
v.NOME_VENDEDOR  as "Nome do Vendedor",
n.VALOR_LIQUIDO as "Mercadorias R$",
ROUND((case 
	when AP.PRODUTOS in('Acessórios', 'Telhas') 
then (n.PESO_ITEM/1000)
	when AP.PRODUTOS in('Recortes') 
	and n.COD_FISCAL not in ('5910','6910','6151','5116','6116')
then (n.PESO_ITEM/1000) else 0 end ),2) as "Ton",
case when n.PESO_ITEM <> 0 then n.VALOR_LIQUIDO / n.PESO_ITEM end as "PM (em Ton)",
(n.VALOR_BRUTO)  as "Fat. Bruto",
(n.VLR_APUR_PIS)+(n.VLR_APUR_COFINS)+(n.VLR_ICMS)+(n.VLR_ICMS_SOL)+(n.VLR_IPI) as "Impostos",
ROUND(((((n.VLR_APUR_PIS)+(n.VLR_APUR_COFINS)+(n.VLR_ICMS)+(n.VLR_ICMS_SOL)+(n.VLR_IPI))/((VALOR_BRUTO)+(VLR_ICMS_SOL)))*100),2) || '%' as "% Impostos",
n.VLR_COMIS_ITEM as "Comissão",
n.D2_COMIS1 || '%'  as "% Comissão",
n.TX_FINANCEIRA  as "Tx. Financeiras",
n.TX_FINANCEIRA / (n.VALOR_TOTAL  + n.ALQ_SOL_ICMS + n.VLR_IPI) as "% Tx. Fin.",
n.VALOR_DECONTO_COMERCIAL_ITEMNF  as "R$ Desc. Com.",
n.VALOR_DECONTO_COMERCIAL_ITEMNF / (n.VALOR_TOTAL  + n.ALQ_SOL_ICMS + n.VLR_IPI) as "% Desc. Com."
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
left join DW.AGRUPADOR_PRODUTO AP on
AP.COD_GRUPOPRODUTO = n.COD_GRUPOPRODUTO
WHERE
AP.PRODUTOS in('Acessórios', 'Recortes', 'Telhas')
and n.FILIAL in ('02', '03')
and t.GERA_DUPLICATA = 'S'
order by n.DT_EMISSAO desc;

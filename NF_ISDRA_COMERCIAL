select 
t2.DESCRICAO  as "Tipo Cliente",
c.NOME  as "NOME CLIENTE",
n.NUMERO_NF  as "Numero NF",
c.ESTADO  as "UF",
n.DT_EMISSAO  as "Período",
n.DT_EMISSAO as "Emissao Pedido",
n.FILIAL  as "Filial",
' '  as "GRUPO",
cp.COND_PGTO  as "Cond. Pag",
p.DESC_GRUPO  as "Grupo de Produto",
' ' as "Dimensão",
' ' as "Descricao do Produto",
' ' as "Municipio",
' ' as "Nome do Vendedor",
' ' as "Mercadorias R$",
' ' as "Ton",
' ' as "PM (em Ton)",
(n.VALOR_BRUTO)  as "Fat. Bruto",
' ' as "Impostos",
' ' as "Impostos",
' ' as "% Impostos",
' ' as "Comissão",
' ' as "% Comissão",
' ' as "Tx. Financeiras",
' ' as "% Tx. Fin.",
' ' as "R$ Desc. Com.",
' ' as "% Desc. Com."
from NFSAIDA n 
left join PRODUTOS p 
on p.CODIGO_PRODUTO = n.CODIGO_PRODUTO 
left join TES t  
on t.CHAVE_TES = n.CHAVE_TES 
inner join CLIENTES c 
on replace(c.CHAVE_CLIENTE, ' ', '') = n.CHAVE_CLIENTE
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

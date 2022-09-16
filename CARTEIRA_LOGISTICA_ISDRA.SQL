select 
s.FILIAL, 
v.NOME_VENDEDOR as "Nome do Vendedor",
c.CLIENTE  as "Codigo do Cliente",
c.NOME  as "Nome do cliente",
s.NUM_PEDIDO  as "Num. Pedido",
s.DATA_ENTREGA  as "Data de Entrega",
st.DESC_STATUS  as "Status",
s.CLASS_FOB  as "Calssificação FOB",
to_char(s.DATA_ENTREGA, 'WW') as "Semana Pedido Entrega",
' ' as "Tipo Cliente",
p.COD_GRUPOPRODUTO  as "Grupo Produto",
' ' as "%Chave da Condição de Pgto", --abreviado
p.DESCRICAO as "Produto",
p.CODIGO_PRODUTO  as "Codigo do Produto",
s.TIPO_FRETE  as "Tipo Frete",
p.DESC_GRUPO  as "Grupo",
' ' as "Motivo",
to_char(s.DATA_ENTREGA,'mm/yyyy')  as "Período",
s.ESTADO_CLIENTE  as "UF",
/* ###### OK ###### */ round((s.VRL_LIQ_SALDO_PED),2)  as "R$ Liquido",
/* ###### OK ###### */  round((s.VALOR_SLD_PEDIDO),2) as "R$",
/* ###### OK ###### */ (SALDO_PESO_ITEM /1000) as "Ton",
/* ###### DIFERENÇA ###### */(case when (SALDO_PESO_ITEM) <> 0 then (s.VRL_LIQ_SALDO_PED) / (SALDO_PESO_ITEM) end)/1000 as "PM (em Ton)",
/* ###### DIFERENCA ###### */round((cp.PRAZO_MEDIO_PGTO),2)  as "Prazo Médio Pagamento",
/* ###### DIFERENCA ###### */round((s.PERC_DESC_ITEM),2) as "% Desconto Pedido"
from PEDIDOS s
left join TES t
on t.CHAVE_TES  = s.CHAVE_TES
left join VENDEDORES v 
on v.CODIGO_VENDEDOR = s.CODIGO_VENDEDOR
left join CLIENTES c 
on c.CHAVE_CLIENTE = s.CHAVE_CLIENTE 
left join PRODUTOS p 
on p.CODIGO_PRODUTO = s.CODIGO_PRODUTO 
left join AUX_STATUS_ITEMPED st 
on st.CODIGO = s.STATUS_ITEM_PEDIDO 
left join CONDICAO_PGTO cp  
on cp.COND_PGTO = s.COND_PGTO 
where STATUS_ITEM_PEDIDO NOT in ('03','09','15')
and PEDIDO_ATIVO = 'A' 
and t.GERA_DUPLICATA = 'S';

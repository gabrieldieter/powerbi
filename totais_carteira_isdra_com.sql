select 
/* ###### OK ###### */ round(sum(s.VRL_LIQ_SALDO_PED),2)  as "R$ Liquido",
/* ###### OK ###### */  round(sum(s.VALOR_SLD_PEDIDO),2) as "R$",
/* ###### OK ###### */ round(sum(SALDO_PESO_ITEM/1000),2)  as "Ton",
/* ###### OK ###### */round((case when sum(SALDO_PESO_ITEM/1000) <> 0 then sum(s.VRL_LIQ_SALDO_PED) / sum(SALDO_PESO_ITEM/1000) end),2) as "PM (em Ton)",
/* ###### DIFERENCA ###### */round(avg(cp.PRAZO_MEDIO_PGTO),2)  as "Prazo Médio Pagamento",
/* ###### DIFERENCA ###### */round(avg(s.PERC_DESC_ITEM),2) as "% Desconto Pedido"
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

SELECT

select email
from sales.customers

select email, first_name, last_name
from sales.customers

select *
from sales.customers

DISTINCT

select distinct brand
from sales.products

select distinct brand, model_year
from sales.products

WHERE

select email, state
from sales.customers
where state = 'SC'

select email, state
from sales.customers
where state = 'SC'or state = 'MS'

select email, state, birth_date
from sales.customers
where (state = 'SC'or state = 'MS') and birth_date < '1991-12-28'

ORDER BY

select *
from sales.products
order by price

select *
from sales.products
order by price desc

select distinct state
from sales.customers
order by state

LIMIT

select *
from sales.funnel
limit 10

select *
from sales.products
order by price desc
limit 10

EXERCICIOS

select distinct city
from sales.customers
where state = 'MG'
order by city

select visit_id
from sales.funnel
where paid_date is not null
order by paid_date desc
limit 10

select *
from sales.customers
where birth_date >= '2000-01-01'
order by score desc
limit 10

OPERADORES ARITMETICOS

select
	email,
	birth_date,
	(current_date - birth_date) / 365 as idade_do_cliente
from sales.customers

select
	email,
	birth_date,
	(current_date - birth_date) / 365 as "idade do cliente"
from sales.customers
order by "idade do cliente"

select
	first_name  || ' ' || last_name as nome_completo
from sales.customers

OPERADDORES DE COMPARACAO

select
	customer_id,
	first_name,
	professional_status,
	(professional_status = 'clt') as cliente_clt
from sales.customers

OPERADORES LOGICOS

select *
from sales.products
where price >= 100000 and price <= 200000

select *
from sales.products
where price between 100000 and 200000

select *
from sales.products
where price < 100000 or price > 200000

select *
from sales.products
where price not between 100000 and 200000

select *
from sales.products
where brand = 'HONDA' or brand = 'TOYOTA' or brand = 'RENAULT'

select *
from sales.products
where brand in ('HONDA', 'TOYOTA', 'RENAULT')

select *
from sales.products
where brand not in ('HONDA', 'TOYOTA', 'RENAULT')

select distinct first_name
from sales.customers
where first_name = 'ANA'

select distinct first_name
from sales.customers 
where first_name like'%ANA'

select distinct first_name
from sales.customers
where first_name ilike'ana%'

select *
from temp_tables.regions

select *
from temp_tables.regions
where population is null

EXERCICIOS

select
	email,
	income,
	(income) / 1200 as "salários mínimos"
from sales.customers

select
	email,
	income,
	(income) / 1200 as "salários mínimos",
	((income) / 1200) > 4 as "acima acima de 4 salários"
from sales.customers
where ((income) / 1200) between 4 and 5

select
	email,
	income,
	(income) / 1200 as "salários mínimos",
	((income) / 1200) > 4 as "acima acima de 4 salários"
from sales.customers

select email, city, state
from sales.customers
where state in ('MG', 'MT')

select email, city, state
from sales.customers
where state not in ('SP')

select city
from temp_tables.regions
where city ilike'z%'

FUNCOES AGREGADAS

select count(*)
from sales.funnel

select count(paid_date)
from sales.funnel

select count(distinct product_id)
from sales.funnel
where visit_page_date between '2021-01-01' and '2021-01-31'

select min(price), max(price), avg(price)
from sales.products

select max(price) from sales.products

select *
from sales.products
where price = (select max(price) from sales.products)

GROUP BY

select state, count(*) as contagem
from sales.customers
group by state
order by contagem desc

select state, professional_status, count(*) as contagem
from sales.customers
group by state, professional_status
order by state, contagem desc

select distinct state
from sales.customers

select state
from sales.customers
group by state

HAVING

select
	state,
	count(*)
from sales.customers
group by state
having count(*) > 100
	and state <> 'MG'

EXERCICIOS

select count(*)
from sales.customers
where ((current_date - birth_date) / 365 ) < 30

select 
	max((current_date - birth_date) / 365 ),
	min((current_date - birth_date) / 365 )
from sales.customers

select *
from sales.customers
where income = (select max(income) from sales.customers)

select brand, count(*)
from sales.products
group by brand
order by brand 

select brand, model_year, count(*)
from sales.products
group by brand, model_year
order by brand , model_year

select brand, count(*)
from sales.products
group by brand
having count(*) > 10 

JOIN

LEFT JOIN

select * from temp_tables.tabela_1
select * from temp_tables.tabela_2

select t1.cpf, t1.name, t2.state
from temp_tables.tabela_1 as t1 left join temp_tables.tabela_2 as t2
on t1.cpf = t2.cpf

INNER JOIN

select * from temp_tables.tabela_1
select * from temp_tables.tabela_2

select t1.cpf, t1.name, t2.state
from temp_tables.tabela_1 as t1 inner join temp_tables.tabela_2 as t2
on t1.cpf = t2.cpf

RIGHT JOIN

select * from temp_tables.tabela_1
select * from temp_tables.tabela_2

select t2.cpf, t1.name, t2.state
from temp_tables.tabela_1 as t1 right join temp_tables.tabela_2 as t2
on t1.cpf = t2.cpf

FULL JOIN

select * from temp_tables.tabela_1
select * from temp_tables.tabela_2

select t2.cpf, t1.name, t2.state
from temp_tables.tabela_1 as t1 full join temp_tables.tabela_2 as t2
on t1.cpf = t2.cpf

//

select
	cus.professional_status,
	count(fun.paid_date) as pagamentos
from sales.funnel as fun
left join sales.customers as cus
	on fun.customer_id = cus.customer_id
	group by cus.professional_status
	order by pagamentos desc

select
	ibge.gender,
	count(fun.paid_date)
from sales.funnel as fun
left join sales.customers as cus
	on fun.customer_id = cus.customer_id
left join temp_tables.ibge_genders as ibge
	on lower(cus.first_name) = ibge.first_name
group by ibge.gender

select
	reg.region,
	count(fun.visit_page_date) as visitas
from sales.funnel as fun
left join sales.customers as cus
	on fun.customer_id = cus.customer_id
left join temp_tables.regions as reg
	on lower (cus.city) = lower (reg.city)
	and lower (cus.state) = lower (reg.state)
group by reg.region
order by visitas desc

EXERCICIOS

select * from sales.funnel limit 10
select * from temp_tables.regions limit 10

select
	prod.brand,
	count(*) as visitas
from sales.funnel as fun
left join sales.products as prod
	on fun.product_id = prod.product_id
group by prod.brand
order by visitas desc

select
	store.store_name,
	count(*) as visitas
from sales.funnel as fun
left join sales.stores as store
	on fun.store_id = store.store_id
group by store.store_name
order by visitas desc

select
	reg.size,
	count(*) as contagem
from sales.customers as cus
left join temp_tables.regions as reg
	on lower (cus.city) = lower(reg.city)
	and lower(cus.state) = lower (reg.state)
group by reg.size
order by contagem

UNION

select * from sales.products
union all
select * from temp_tables.products_2

SUBQUERY

select *
from sales.products
where price = (select min(price) from sales.products)

with alguma_tabela as (

select
	professional_status,
	(current_date - birth_date)/365 as idade
from sales.customers

)
select 
	professional_status,
	avg(idade) as idade_media
from alguma_tabela
group by professional status

select 
	professional_status,
	avg(idade) as idade_media
from (

select
	professional_status,
	(current_date - birth_date)/365 as idade
from sales.customers
)as alguma_tabela
group by professional_status

select
	fun.visit_id,
	fun.visit_page_date,
	sto.store_name,
	(
		select count(*)
		from sales.funnel as fun2
		where fun2.visit_page_date <= fun.visit_page_date
		 	and fun2.store_id = fun.store_id
	) as visitas_acumuladas
from sales.funnel as fun
left join sales.stores as sto
	on fun.store_id = sto.store_id
order by sto.store_name, fun.visit_page_date

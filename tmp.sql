		
	SELECT
    stats_date
    ,app_name
    ,country
    ,media_source
    ,campaign
    ,product_cat
    ,site_id
    ,installs
    ,cost
    ,gg_install
    ,gg_cost
    ,af_install_device_uv
    ,server_active_uv
    ,vip_purchase_show_uv
    ,vip_purchase_click_uv
    ,total_revenue
    ,total_revenue_week
    ,total_revenue_month
    ,total_revenue_yearx
    ,total_revenue_other
    ,af_try_uv
    ,af_try_uv_week
    ,af_try_uv_month
    ,af_try_uv_year
    ,af_try_uv_other
    ,af_pay_uv
    ,af_pay_uv_week
    ,af_pay_uv_month
    ,af_pay_uv_year
    ,af_pay_uv_other
    ,af_pay_pv
    ,af_pay_pv_week
    ,af_pay_pv_month
    ,af_pay_pv_year
    ,af_pay_pv_other
    ,total_uv
    ,total_month
    ,total_year
    ,total_week
    ,total_other
    ,case when media_source not in ('unkonwn','unknown') and  tui_uv>af_pay_pv then af_pay_pv else tui_uv end as tui_uv
    ,case when media_source not in ('unkonwn','unknown') and  tui_uv_month>af_pay_pv_month then af_pay_pv_month else tui_uv_month end as tui_uv_month
    ,case when media_source not in ('unkonwn','unknown') and  tui_uv_year>af_pay_pv_year then af_pay_pv_year else tui_uv_year end as tui_uv_year
    ,case when media_source not in ('unkonwn','unknown') and  tui_uv_week>af_pay_pv_week then af_pay_pv_week else tui_uv_week end as tui_uv_week
    ,case when media_source not in ('unkonwn','unknown') and  tui_uv_other>af_pay_pv_other then af_pay_pv_other else tui_uv_other end as tui_uv_other
FROM
    (
    SELECT
        stats_date
        ,app_name
        ,country
        ,media_source
        ,campaign
        ,product_cat
        ,site_id
        ,sum(installs) as installs
        ,sum(cost) as cost
        ,sum(gg_install) as gg_install
        ,sum(gg_cost) as gg_cost
        ,sum(af_install_device_uv) as af_install_device_uv
        ,sum(server_active_uv) as server_active_uv
        ,sum(vip_purchase_show_uv) as vip_purchase_show_uv
        ,sum(vip_purchase_click_uv) as vip_purchase_click_uv
        ,sum(total_revenue) as total_revenue
        ,sum(total_revenue_week) as total_revenue_week
        ,sum(total_revenue_month) as total_revenue_month
        ,sum(total_revenue_year) as total_revenue_year
        ,sum(total_revenue_other) as total_revenue_other
        ,sum(af_try_uv) as af_try_uv
        ,sum(af_try_uv_week) as af_try_uv_week
        ,sum(af_try_uv_month) as af_try_uv_month
        ,sum(af_try_uv_year) as af_try_uv_year
        ,sum(af_try_uv_other) as af_try_uv_other
        ,sum(af_pay_uv) as af_pay_uv
        ,sum(af_pay_uv_week) as af_pay_uv_week
        ,sum(af_pay_uv_month) as af_pay_uv_month
        ,sum(af_pay_uv_year) as af_pay_uv_year
        ,sum(af_pay_uv_other) as af_pay_uv_other
        ,sum(af_pay_pv) as af_pay_pv
        ,sum(af_pay_pv_week) as af_pay_pv_week
        ,sum(af_pay_pv_month) as af_pay_pv_month
        ,sum(af_pay_pv_year) as af_pay_pv_year
        ,sum(af_pay_pv_other) as af_pay_pv_other
        ,sum(total_uv) as total_uv, 
        sum(total_month) as total_month, 
        sum(total_year) as total_year, 
        sum(total_week) as total_week, 
        sum(total_other) as total_other, 
        sum(tui_uv) as tui_uv, 
        sum(tui_uv_month) as tui_uv_month, 
        sum(tui_uv_year) as tui_uv_year, 
        sum(tui_uv_week) as tui_uv_week, 
        sum(tui_uv_other) as tui_uv_other
    FROM
        (
        SELECT  
            stats_date
            ,app_name
            ,country
            ,media_source
            ,campaign
            ,'total' as product_cat
            ,site_id
            ,sum(installs) as installs
            ,sum(cost) as cost
            ,sum(gg_install) as gg_install
            ,sum(gg_cost) as gg_cost
            ,sum(af_install_device_uv) as af_install_device_uv
            ,sum(server_active_uv) as server_active_uv
            ,sum(vip_purchase_show_uv) as vip_purchase_show_uv
            ,sum(vip_purchase_click_uv) as vip_purchase_click_uv
            ,0 as total_uv, 
            0 as total_month, 
            0 as total_year, 
            0 as total_week, 
            0 as total_other, 
            0 as tui_uv, 
            0 as tui_uv_month, 
            0 as tui_uv_year, 
            0 as tui_uv_week, 
            0 as tui_uv_other
            ,0 as total_revenue
            ,0 as total_revenue_week
            ,0 as total_revenue_month
            ,0 as total_revenue_year
            ,0 as total_revenue_other
            ,0 as af_try_uv
            ,0 as af_try_uv_week
            ,0 as af_try_uv_month
            ,0 as af_try_uv_year
            ,0 as af_try_uv_other
            ,0 as af_pay_uv
            ,0 as af_pay_uv_week
            ,0 as af_pay_uv_month
            ,0 as af_pay_uv_year
            ,0 as af_pay_uv_other
            ,0 as af_pay_pv
            ,0 as af_pay_pv_week
            ,0 as af_pay_pv_month
            ,0 as af_pay_pv_year
            ,0 as af_pay_pv_other
        FROM `vpnspeeddata.core_data.purchase_summary_v2`
        WHERE   DATE(stats_date) >= DATE_SUB("{stats_date}", INTERVAL 40 DAY)
        and DATE(stats_date) <= DATE_SUB("{stats_date}", INTERVAL 0 DAY)
        --and site_id ='total'
        and campaign_serious='total'
        group by stats_date,app_name,country,media_source,product_cat,campaign,site_id
        union all 
        SELECT 
            stats_date,
            app_name, 
            country, 
            af_status, 
            media_source, 
            campaign, 
            site_id
            ,0 as installs
            ,0 as cost
            ,0 as gg_install
            ,0 as gg_cost
            ,0 as af_install_device_uv
            ,0 as server_active_uv
            ,0 as vip_purchase_show_uv
            ,0 as vip_purchase_click_uv
            ,total_uv, 
            total_month, 
            total_year, 
            total_week, 
            total_other, 
            tui_uv, 
            tui_uv_month, 
            tui_uv_year, 
            tui_uv_week, 
            tui_uv_other
            ,0 as total_revenue
            ,0 as total_revenue_week
            ,0 as total_revenue_month
            ,0 as total_revenue_year
            ,0 as total_revenue_other
            ,0 as af_try_uv
            ,0 as af_try_uv_week
            ,0 as af_try_uv_month
            ,0 as af_try_uv_year
            ,0 as af_try_uv_other
            ,0 as af_pay_uv
            ,0 as af_pay_uv_week
            ,0 as af_pay_uv_month
            ,0 as af_pay_uv_year
            ,0 as af_pay_uv_other
            ,0 as af_pay_pv
            ,0 as af_pay_pv_week
            ,0 as af_pay_pv_month
            ,0 as af_pay_pv_year
            ,0 as af_pay_pv_other
        FROM `vpnspeeddata.core_data.purchase_tuikuan_report` 
        WHERE  DATE(stats_date) >= DATE_SUB("{stats_date}", INTERVAL 40 DAY)
        and DATE(stats_date) <= DATE_SUB("{stats_date}", INTERVAL 0 DAY)
        union all 
        SELECT
            cast(a.stats_date as timestamp ) as stats_date
            ,a.app_name
            ,a.country
            ,a.media_source				
            ,a.campaign
            ,a.product_cat
            ,a.site_id
            ,0 as installs
            ,0 as cost
            ,0 as gg_install
            ,0 as gg_cost
            ,0 as af_install_device_uv
            ,0 as server_active_uv
            ,0 as vip_purchase_show_uv
            ,0 as vip_purchase_click_uv
            ,0 as total_uv, 
            0 as total_month, 
            0 as total_year, 
            0 as total_week, 
            0 as total_other, 
            0 as tui_uv, 
            0 as tui_uv_month, 
            0 as tui_uv_year, 
            0 as tui_uv_week, 
            0 as tui_uv_other
            ,ifnull(a.total_revenue,b.total_revenue) as total_revenue
            ,ifnull(b.total_revenue_week,a.total_revenue_week) as total_revenue_week
            ,ifnull(b.total_revenue_month,a.total_revenue_month) as total_revenue_month
            ,ifnull(b.total_revenue_year,a.total_revenue_year) as total_revenue_year
            ,ifnull(b.total_revenue_other,a.total_revenue_other) as total_revenue_other
            ,ifnull(a.af_try_uv,b.af_try_uv) as af_try_uv
            ,ifnull(b.af_try_uv_week,a.af_try_uv_week) as af_try_uv_week
            ,ifnull(b.af_try_uv_month,a.af_try_uv_month) as af_try_uv_month
            ,ifnull(b.af_try_uv_year,a.af_try_uv_year) as af_try_uv_year
            ,ifnull(b.af_try_uv_other,a.af_try_uv_other) as af_try_uv_other
            ,ifnull(a.af_pay_uv,b.af_pay_uv) as af_pay_uv
            ,ifnull(b.af_pay_uv_week,a.af_pay_uv_week) as af_pay_uv_week
            ,ifnull(b.af_pay_uv_month,a.af_pay_uv_month) as af_pay_uv_month
            ,ifnull(b.af_pay_uv_year,a.af_pay_uv_year) as af_pay_uv_year
            ,ifnull(b.af_pay_uv_other,a.af_pay_uv_other) as af_pay_uv_other
            ,ifnull(a.af_pay_pv,b.af_pay_pv) as af_pay_pv
            ,ifnull(b.af_pay_pv_week,a.af_pay_pv_week) as af_pay_pv_week
            ,ifnull(b.af_pay_pv_month,a.af_pay_pv_month) as af_pay_pv_month
            ,ifnull(b.af_pay_pv_year,a.af_pay_pv_year) as af_pay_pv_year
            ,ifnull(b.af_pay_pv_other,a.af_pay_pv_other) as af_pay_pv_other
        FROM
            (
            SELECT
                stats_date
                ,app_name
                ,country
                ,media_source
                ,product_cat
                ,campaign
                ,site_id
                ,max(  total_revenue  ) as total_revenue
                ,max(case when 	product_cat ='weekly' then total_revenue else null end ) as total_revenue_week
                ,max(case when 	product_cat ='monthly' then total_revenue else null end) as total_revenue_month
                ,max(case when 	product_cat ='yearly' then total_revenue else null end ) as total_revenue_year
                ,max(case when 	product_cat not in ('weekly','monthly','yearly','total') then total_revenue else null end) as total_revenue_other
                ,max(  af_try_uv  ) as af_try_uv
                --,max(case when 	product_cat ='total' then af_try_uv else null end ) as af_try_uv
                ,max(case when 	product_cat ='weekly' then af_try_uv else null end ) as af_try_uv_week
                ,max(case when 	product_cat ='monthly' then af_try_uv else null end ) as af_try_uv_month
                ,max(case when 	product_cat ='yearly' then af_try_uv else null end)  as af_try_uv_year
                ,max(case when 	product_cat not in ('weekly','monthly','yearly','total') then af_try_uv else null end ) as af_try_uv_other
                ,max(  af_pay_uv  ) as af_pay_uv
                --,max(case when 	product_cat ='total' then af_pay_uv else null end)  as af_pay_uv
                ,max(case when 	product_cat ='weekly' then af_pay_uv else null end)  as af_pay_uv_week
                ,max(case when 	product_cat ='monthly' then af_pay_uv else null end)  as af_pay_uv_month
                ,max(case when 	product_cat ='yearly' then af_pay_uv else null end ) as af_pay_uv_year
                ,max(case when 	product_cat not in ('weekly','monthly','yearly','total') then af_pay_uv else null end) as af_pay_uv_other
                ,max(  af_pay_pv  ) as af_pay_pv
                --,max(case when 	product_cat ='total' then af_pay_pv else null end)  as af_pay_pv
                ,max(case when 	product_cat ='weekly' then af_pay_pv else null end ) as af_pay_pv_week
                ,max(case when 	product_cat ='monthly' then af_pay_pv else null end)  as af_pay_pv_month
                ,max(case when 	product_cat ='yearly' then af_pay_pv else null end)  as af_pay_pv_year
                ,max(case when 	product_cat not in ('weekly','monthly','yearly','total') then af_pay_pv else null end) as af_pay_pv_other
            FROM
                (
                SELECT
                    stats_date
                    ,a.app_name
                    ,country
                    ,media_source
                    ,campaign
                    ,site_id
                    ,case when a.product_id ='total' then 'total' 
                    when a.product_id !='total' and product_cat is not null and product_cat not in ("unkonwn",'unknown') then product_cat
                    when (a.product_id like '%year%' or a.product_id like '%12%' ) then 'yearly'
                    when (a.product_id like '%week%'  ) then 'weekly'
                    else  'monthly' end as   product_cat  
                    ,sum(total_revenue) as total_revenue
                    ,sum(af_pay_uv) as af_pay_uv
                    ,sum(af_pay_pv) as af_pay_pv
                    ,sum(af_try_uv) as af_try_uv
                FROM
                    (
                    SELECT
                        DATE(stats_date) AS stats_date
                        ,app_name
                        ,country
                        ,product_id
                        ,media_source
                        ,campaign
                        ,total_revenue
                        ,af_pay_uv
                        ,af_pay_pv
                        ,af_try_uv
                        ,site_id
                    FROM `vpnspeeddata.core_data.purchase_revenue`
                    WHERE DATE(stats_date) >= DATE_SUB("{stats_date}", INTERVAL 40 DAY)
                    and DATE(stats_date)<= DATE_SUB("{stats_date}", INTERVAL 0 DAY)
                    --and  DATE(stats_date) ='2021-08-04'
                    --and app_name ='Master_iOS'
                    and af_status ='total'
                    --and site_id ='total'
                    --and product_id ='total'
                    )a
                    left join
                    (
                    SELECT
                        app_name
                        ,product_id
                        ,product_cat
                    FROM `vpnspeeddata.core_data.new_product_id_mapping`
                    group by app_name,product_id,product_cat
                    )b
                    on a.app_name=b.app_name
                    and a.product_id=b.product_id
                    group by stats_date,a.app_name,country,media_source,product_cat,campaign,site_id
                )c 
            group by stats_date,app_name,country,media_source,product_cat,campaign,site_id
            )a 
            left join
            (
            SELECT
                stats_date
                ,app_name
                ,country
                ,media_source
                ,'total' as product_cat
                ,campaign
                ,site_id
                ,max(case when 	product_cat ='total' then total_revenue else null end ) as total_revenue
                ,max(case when 	product_cat ='weekly' then total_revenue else null end ) as total_revenue_week
                ,max(case when 	product_cat ='monthly' then total_revenue else null end) as total_revenue_month
                ,max(case when 	product_cat ='yearly' then total_revenue else null end ) as total_revenue_year
                ,max(case when 	product_cat not in ('weekly','monthly','yearly','total') then total_revenue else null end) as total_revenue_other
                ,max(case when 	product_cat ='total' then af_try_uv else null end ) as af_try_uv
                ,max(case when 	product_cat ='weekly' then af_try_uv else null end ) as af_try_uv_week
                ,max(case when 	product_cat ='monthly' then af_try_uv else null end ) as af_try_uv_month
                ,max(case when 	product_cat ='yearly' then af_try_uv else null end)  as af_try_uv_year
                ,max(case when 	product_cat not in ('weekly','monthly','yearly','total') then af_try_uv else null end ) as af_try_uv_other
                ,max(case when 	product_cat ='total' then af_pay_uv else null end)  as af_pay_uv
                ,max(case when 	product_cat ='weekly' then af_pay_uv else null end)  as af_pay_uv_week
                ,max(case when 	product_cat ='monthly' then af_pay_uv else null end)  as af_pay_uv_month
                ,max(case when 	product_cat ='yearly' then af_pay_uv else null end ) as af_pay_uv_year
                ,max(case when 	product_cat not in ('weekly','monthly','yearly','total') then af_pay_uv else null end) as af_pay_uv_other
                ,max(case when 	product_cat ='total' then af_pay_pv else null end)  as af_pay_pv
                ,max(case when 	product_cat ='weekly' then af_pay_pv else null end ) as af_pay_pv_week
                ,max(case when 	product_cat ='monthly' then af_pay_pv else null end)  as af_pay_pv_month
                ,max(case when 	product_cat ='yearly' then af_pay_pv else null end)  as af_pay_pv_year
                ,max(case when 	product_cat not in ('weekly','monthly','yearly','total') then af_pay_pv else null end) as af_pay_pv_other
            FROM
                (
                SELECT
                    stats_date
                    ,a.app_name
                    ,country
                    ,media_source
                    ,campaign
                    ,site_id
                    ,case when a.product_id ='total' then 'total' 
                    when a.product_id !='total' and product_cat is not null and product_cat not in ("unkonwn",'unknown') then product_cat
                    when (a.product_id like '%year%' or a.product_id like '%12%' ) then 'yearly'
                    when (a.product_id like '%week%'  ) then 'weekly'
                    else  'monthly' end as   product_cat  
                    ,sum(total_revenue) as total_revenue
                    ,sum(af_pay_uv) as af_pay_uv
                    ,sum(af_pay_pv) as af_pay_pv
                    ,sum(af_try_uv) as af_try_uv
                FROM
                    (
                    SELECT
                        DATE(stats_date) AS stats_date
                        ,app_name
                        ,country
                        ,product_id
                        ,media_source
                        ,campaign
                        ,total_revenue
                        ,af_pay_uv
                        ,af_pay_pv
                        ,af_try_uv
                        ,site_id
                    FROM `vpnspeeddata.core_data.purchase_revenue`
                    WHERE DATE(stats_date) >= DATE_SUB("{stats_date}", INTERVAL 40 DAY)
                    and DATE(stats_date)<= DATE_SUB("{stats_date}", INTERVAL 0 DAY)
                    and af_status ='total'
                    --and site_id ='total'
                    and product_id !='total'
                    )a
                    left join
                    (
                    SELECT
                        app_name
                        ,product_id
                        ,product_cat
                    FROM `vpnspeeddata.core_data.new_product_id_mapping`
                    group by app_name,product_id,product_cat
                    )b
                    on a.app_name=b.app_name
                    and a.product_id=b.product_id
                    group by stats_date,a.app_name,country,media_source,product_cat,campaign,site_id
                )c 
            group by stats_date,app_name,country,media_source,product_cat,campaign,site_id
            )b 
            on a.stats_date=b.stats_date
            and a.app_name=b.app_name
            and a.country=b.country
            and a.media_source=b.media_source
            and a.campaign=b.campaign
            and a.product_cat=b.product_cat
            and a.site_id=b.site_id
        union all 
        SELECT  
            stats_date
            ,app_name
            ,country
            ,'unkonwn' as media_source
            ,'total' as campaign
            ,'total' as product_cat
            ,'total' as site_id
            ,sum(0) as installs
            ,sum(0) as cost
            ,sum(0) as gg_install
            ,sum(0) as gg_cost
            ,sum(0) as af_install_device_uv
            ,sum(launch_uv) as server_active_uv
            ,sum(vip_purchase_show_uv) as vip_purchase_show_uv
            ,sum(vip_purchase_click_uv) as vip_purchase_click_uv
            ,0 as total_uv, 
            0 as total_month, 
            0 as total_year, 
            0 as total_week, 
            0 as total_other, 
            0 as tui_uv, 
            0 as tui_uv_month, 
            0 as tui_uv_year, 
            0 as tui_uv_week, 
            0 as tui_uv_other
            ,0 as total_revenue
            ,0 as total_revenue_week
            ,0 as total_revenue_month
            ,0 as total_revenue_year
            ,0 as total_revenue_other
            ,0 as af_try_uv
            ,0 as af_try_uv_week
            ,0 as af_try_uv_month
            ,0 as af_try_uv_year
            ,0 as af_try_uv_other
            ,0 as af_pay_uv
            ,0 as af_pay_uv_week
            ,0 as af_pay_uv_month
            ,0 as af_pay_uv_year
            ,0 as af_pay_uv_other
            ,0 as af_pay_pv
            ,0 as af_pay_pv_week
            ,0 as af_pay_pv_month
            ,0 as af_pay_pv_year
            ,0 as af_pay_pv_other
        FROM `vpnspeeddata.core_data.vip_summary` 
        WHERE   DATE(stats_date) >= DATE_SUB("{stats_date}", INTERVAL 40 DAY)
        and DATE(stats_date) <= DATE_SUB("{stats_date}", INTERVAL 0 DAY)
        AND is_new_user IN ('1') 
        AND source = 'total' 
        AND version = 'total' 
        AND media_source IN ('unkonwn') 
        AND channel = 'total' 
        AND product_id = 'total' 
        AND campaign = 'total' 
        group by stats_date,app_name,country,media_source,product_cat,campaign,site_id
        union all 
        SELECT
            cast(a.stats_date as timestamp ) as stats_date
            ,a.app_name
            ,a.country
            ,a.media_source				
            ,a.campaign
            ,a.product_cat
            ,a.site_id
            ,0 as installs
            ,0 as cost
            ,0 as gg_install
            ,0 as gg_cost
            ,0 as af_install_device_uv
            ,0 as server_active_uv
            ,0 as vip_purchase_show_uv
            ,0 as vip_purchase_click_uv
            ,0 as total_uv, 
            0 as total_month, 
            0 as total_year, 
            0 as total_week, 
            0 as total_other, 
            0 as tui_uv, 
            0 as tui_uv_month, 
            0 as tui_uv_year, 
            0 as tui_uv_week, 
            0 as tui_uv_other
            ,ifnull(a.total_revenue,b.total_revenue) as total_revenue
            ,ifnull(b.total_revenue_week,a.total_revenue_week) as total_revenue_week
            ,ifnull(b.total_revenue_month,a.total_revenue_month) as total_revenue_month
            ,ifnull(b.total_revenue_year,a.total_revenue_year) as total_revenue_year
            ,ifnull(b.total_revenue_other,a.total_revenue_other) as total_revenue_other
            ,ifnull(a.af_try_uv,b.af_try_uv) as af_try_uv
            ,ifnull(b.af_try_uv_week,a.af_try_uv_week) as af_try_uv_week
            ,ifnull(b.af_try_uv_month,a.af_try_uv_month) as af_try_uv_month
            ,ifnull(b.af_try_uv_year,a.af_try_uv_year) as af_try_uv_year
            ,ifnull(b.af_try_uv_other,a.af_try_uv_other) as af_try_uv_other
            ,ifnull(a.af_pay_uv,b.af_pay_uv) as af_pay_uv
            ,ifnull(b.af_pay_uv_week,a.af_pay_uv_week) as af_pay_uv_week
            ,ifnull(b.af_pay_uv_month,a.af_pay_uv_month) as af_pay_uv_month
            ,ifnull(b.af_pay_uv_year,a.af_pay_uv_year) as af_pay_uv_year
            ,ifnull(b.af_pay_uv_other,a.af_pay_uv_other) as af_pay_uv_other
            ,ifnull(a.af_pay_pv,b.af_pay_pv) as af_pay_pv
            ,ifnull(b.af_pay_pv_week,a.af_pay_pv_week) as af_pay_pv_week
            ,ifnull(b.af_pay_pv_month,a.af_pay_pv_month) as af_pay_pv_month
            ,ifnull(b.af_pay_pv_year,a.af_pay_pv_year) as af_pay_pv_year
            ,ifnull(b.af_pay_pv_other,a.af_pay_pv_other) as af_pay_pv_other
        FROM
            (
            SELECT
                stats_date
                ,app_name
                ,country
                ,media_source
                ,product_cat
                ,campaign
                ,site_id
                ,max(  total_revenue  ) as total_revenue
                ,max(case when 	product_cat ='weekly' then total_revenue else null end ) as total_revenue_week
                ,max(case when 	product_cat ='monthly' then total_revenue else null end) as total_revenue_month
                ,max(case when 	product_cat ='yearly' then total_revenue else null end ) as total_revenue_year
                ,max(case when 	product_cat not in ('weekly','monthly','yearly','total') then total_revenue else null end) as total_revenue_other
                ,max(  af_try_uv  ) as af_try_uv
                --,max(case when 	product_cat ='total' then af_try_uv else null end ) as af_try_uv
                ,max(case when 	product_cat ='weekly' then af_try_uv else null end ) as af_try_uv_week
                ,max(case when 	product_cat ='monthly' then af_try_uv else null end ) as af_try_uv_month
                ,max(case when 	product_cat ='yearly' then af_try_uv else null end)  as af_try_uv_year
                ,max(case when 	product_cat not in ('weekly','monthly','yearly','total') then af_try_uv else null end ) as af_try_uv_other
                ,max(  af_pay_uv  ) as af_pay_uv
                --,max(case when 	product_cat ='total' then af_pay_uv else null end)  as af_pay_uv
                ,max(case when 	product_cat ='weekly' then af_pay_uv else null end)  as af_pay_uv_week
                ,max(case when 	product_cat ='monthly' then af_pay_uv else null end)  as af_pay_uv_month
                ,max(case when 	product_cat ='yearly' then af_pay_uv else null end ) as af_pay_uv_year
                ,max(case when 	product_cat not in ('weekly','monthly','yearly','total') then af_pay_uv else null end) as af_pay_uv_other
                ,max(  af_pay_pv  ) as af_pay_pv
                --,max(case when 	product_cat ='total' then af_pay_pv else null end)  as af_pay_pv
                ,max(case when 	product_cat ='weekly' then af_pay_pv else null end ) as af_pay_pv_week
                ,max(case when 	product_cat ='monthly' then af_pay_pv else null end)  as af_pay_pv_month
                ,max(case when 	product_cat ='yearly' then af_pay_pv else null end)  as af_pay_pv_year
                ,max(case when 	product_cat not in ('weekly','monthly','yearly','total') then af_pay_pv else null end) as af_pay_pv_other
            FROM
                (
                SELECT
                    stats_date
                    ,a.app_name
                    ,country
                    ,'unkonwn' as media_source
                    ,'total' as campaign
                    ,'total' as site_id
                    ,case when a.product_id ='total' then 'total' 
                    when a.product_id !='total' and product_cat is not null and product_cat not in ("unkonwn",'unknown') then product_cat
                    when (a.product_id like '%year%' or a.product_id like '%12%' ) then 'yearly'
                    when (a.product_id like '%week%'  ) then 'weekly'
                    else  'monthly' end as   product_cat  
                    ,sum(total_revenue) as total_revenue
                    ,sum(af_pay_uv) as af_pay_uv
                    ,sum(af_pay_pv) as af_pay_pv
                    ,sum(af_try_uv) as af_try_uv
                FROM
                    (
                    SELECT
                        DATE(stats_date) AS stats_date
                        ,app_name
                        ,country
                        ,product_id
                        ,media_source
                        ,campaign
                        ,price*0.7 as total_revenue
                        ,vip_pay_uv as af_pay_uv
                        ,vip_pay_uv as af_pay_pv
                        ,vip_trial_uv as af_try_uv
                    FROM `vpnspeeddata.core_data.vip_summary`
                    WHERE DATE(stats_date) >= DATE_SUB("{stats_date}", INTERVAL 40 DAY)
                    and DATE(stats_date)<= DATE_SUB("{stats_date}", INTERVAL 0 DAY)
                    AND is_new_user IN ('1') 
                    AND source = 'total' 
                    AND version = 'total' 
                    AND media_source IN ('unkonwn') 
                    AND channel = 'total' 
                    --AND product_id = 'total' 
                    AND campaign = 'total' 
                    )a
                    left join
                    (
                    SELECT
                        app_name
                        ,product_id
                        ,product_cat
                    FROM `vpnspeeddata.core_data.new_product_id_mapping`
                    group by app_name,product_id,product_cat
                    )b
                    on a.app_name=b.app_name
                    and a.product_id=b.product_id
                    group by stats_date,a.app_name,country,media_source,product_cat,campaign,site_id
                )c 
            group by stats_date,app_name,country,media_source,product_cat,campaign,site_id
            )a 
            left join
            (
            SELECT
                stats_date
                ,app_name
                ,country
                ,media_source
                ,'total' as product_cat
                ,campaign
                ,site_id
                ,max(case when 	product_cat ='total' then total_revenue else null end ) as total_revenue
                ,max(case when 	product_cat ='weekly' then total_revenue else null end ) as total_revenue_week
                ,max(case when 	product_cat ='monthly' then total_revenue else null end) as total_revenue_month
                ,max(case when 	product_cat ='yearly' then total_revenue else null end ) as total_revenue_year
                ,max(case when 	product_cat not in ('weekly','monthly','yearly','total') then total_revenue else null end) as total_revenue_other
                ,max(case when 	product_cat ='total' then af_try_uv else null end ) as af_try_uv
                ,max(case when 	product_cat ='weekly' then af_try_uv else null end ) as af_try_uv_week
                ,max(case when 	product_cat ='monthly' then af_try_uv else null end ) as af_try_uv_month
                ,max(case when 	product_cat ='yearly' then af_try_uv else null end)  as af_try_uv_year
                ,max(case when 	product_cat not in ('weekly','monthly','yearly','total') then af_try_uv else null end ) as af_try_uv_other
                ,max(case when 	product_cat ='total' then af_pay_uv else null end)  as af_pay_uv
                ,max(case when 	product_cat ='weekly' then af_pay_uv else null end)  as af_pay_uv_week
                ,max(case when 	product_cat ='monthly' then af_pay_uv else null end)  as af_pay_uv_month
                ,max(case when 	product_cat ='yearly' then af_pay_uv else null end ) as af_pay_uv_year
                ,max(case when 	product_cat not in ('weekly','monthly','yearly','total') then af_pay_uv else null end) as af_pay_uv_other
                ,max(case when 	product_cat ='total' then af_pay_pv else null end)  as af_pay_pv
                ,max(case when 	product_cat ='weekly' then af_pay_pv else null end ) as af_pay_pv_week
                ,max(case when 	product_cat ='monthly' then af_pay_pv else null end)  as af_pay_pv_month
                ,max(case when 	product_cat ='yearly' then af_pay_pv else null end)  as af_pay_pv_year
                ,max(case when 	product_cat not in ('weekly','monthly','yearly','total') then af_pay_pv else null end) as af_pay_pv_other
            FROM
                (
                SELECT
                    stats_date
                    ,a.app_name
                    ,country
                    ,'unkonwn' as media_source
                    ,'total' as campaign
                    ,'total' as site_id
                    ,case when a.product_id ='total' then 'total' 
                    when a.product_id !='total' and product_cat is not null and product_cat not in ("unkonwn",'unknown') then product_cat
                    when (a.product_id like '%year%' or a.product_id like '%12%' ) then 'yearly'
                    when (a.product_id like '%week%'  ) then 'weekly'
                    else  'monthly' end as   product_cat  
                    ,sum(total_revenue) as total_revenue
                    ,sum(af_pay_uv) as af_pay_uv
                    ,sum(af_pay_pv) as af_pay_pv
                    ,sum(af_try_uv) as af_try_uv
                FROM
                    (
                    SELECT
                        DATE(stats_date) AS stats_date
                        ,app_name
                        ,country
                        ,product_id
                        ,media_source
                        ,campaign
                        ,price*0.7 as total_revenue
                        ,vip_pay_uv as af_pay_uv
                        ,vip_pay_uv as af_pay_pv
                        ,vip_trial_uv as af_try_uv
                    FROM `vpnspeeddata.core_data.vip_summary`
                    WHERE DATE(stats_date) >= DATE_SUB("{stats_date}", INTERVAL 40 DAY)
                    and DATE(stats_date)<= DATE_SUB("{stats_date}", INTERVAL 0 DAY)
                    AND is_new_user IN ('1') 
                    AND source = 'total' 
                    AND version = 'total' 
                    AND media_source IN ('unkonwn') 
                    AND channel = 'total' 
                    AND campaign = 'total' 
                    and product_id !='total'
                    )a
                    left join
                    (
                    SELECT
                        app_name
                        ,product_id
                        ,product_cat
                    FROM `vpnspeeddata.core_data.new_product_id_mapping`
                    group by app_name,product_id,product_cat
                    )b
                    on a.app_name=b.app_name
                    and a.product_id=b.product_id
                    group by stats_date,a.app_name,country,media_source,product_cat,campaign,site_id
                )c 
            group by stats_date,app_name,country,media_source,product_cat,campaign,site_id
            )b 
            on a.stats_date=b.stats_date
            and a.app_name=b.app_name
            and a.country=b.country
            and a.media_source=b.media_source
            and a.campaign=b.campaign
            and a.product_cat=b.product_cat
            and a.site_id=b.site_id
        )c 
        group by stats_date,app_name,country,media_source,campaign,product_cat,site_id
    )d

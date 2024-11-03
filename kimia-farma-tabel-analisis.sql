CREATE TABLE `rakamin-kimia-farma-440511.kimia_farma.tabel_analisa` AS
SELECT
    ft.transaction_id,
    ft.date,
    ft.branch_id,
    kc.branch_name,
    kc.kota,
    kc.provinsi,
    kc.rating AS rating_cabang,
    ft.customer_name,
    ft.product_id,
    p.product_name,
    p.price AS actual_price,
    ft.discount_percentage,
    CASE
      WHEN ft.price <= 50000 THEN 0.10
      WHEN ft.price > 50000 AND ft.price <= 100000 THEN 0.15
      WHEN ft.price > 100000 AND ft.price <= 300000 THEN 0.20
      WHEN ft.price > 300000 AND ft.price <= 500000 THEN 0.25
      WHEN ft.price > 500000 THEN 0.30
    END AS persentase_gross_laba,
    ft.rating AS rating_transaksi,
    p.price * (1 - ft.discount_percentage / 100) AS nett_sales,
    p.price * (1 - ft.discount_percentage / 100) * CASE
      WHEN ft.price <= 50000 THEN 0.10
      WHEN ft.price > 50000 AND ft.price <= 100000 THEN 0.15
      WHEN ft.price > 100000 AND ft.price <= 300000 THEN 0.20
      WHEN ft.price > 300000 AND ft.price <= 500000 THEN 0.25
      WHEN ft.price > 500000 THEN 0.30
    END AS nett_profit
FROM
    `rakamin-kimia-farma-440511.kimia_farma.kf_final_transaction` AS ft
JOIN
    `rakamin-kimia-farma-440511.kimia_farma.kf_kantor_cabang` AS kc ON ft.branch_id = kc.branch_id
JOIN
    `rakamin-kimia-farma-440511.kimia_farma.kf_product` AS p ON ft.product_id = p.product_id;
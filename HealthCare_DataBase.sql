SELECT 3.516, round(3.516,0), round(3.516,1), round(3.516,2);

SELECT
    Price,
    Tax,
    Price + Tax AS Final_Price
FROM Products;
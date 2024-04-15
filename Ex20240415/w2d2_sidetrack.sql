SELECT deptno, dname, city
FROM my_db.dept as dept, my_db.locations as locations
where dept.loc_code = locations.loc_code
;
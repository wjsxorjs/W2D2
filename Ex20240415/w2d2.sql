-- 보너스가 있는 사원들의 사번, 이름, 급여, 보너스를
-- 급여의 역순으로 정렬하여 나타내라
SELECT empno, ename, sal, comm
FROM emp
WHERE comm IS NOT NULL
ORDER BY sal DESC 
;
-- 보너스가 있는 사원들의 사번, 이름, 급여, 보너스를
-- 급여의 역순으로 정렬하여 나타내라
SELECT empno, ename, sal, comm
FROM emp
WHERE comm IS NOT NULL
ORDER BY sal DESC 
;

-- ====================| 2024.04.15 AM |=========================

-- 문자 조작함수 활용
-- 예) emp테이블에서 직종의 값들 중 "LE"가 있는
--    위치를 알아내자
SELECT empno, ename, job, INSTR(job,'LE') as indexOf_LE
FROM emp;
-- 표현되는 위치값은 index값이 아니다. (위치값 : 1, 2, 3, ...)

-- 예) emp테이블에서 각 사원들의 정보를 사번, 이름, 직종,
--    그리고 입사일에서 입사년도만 추출하여 출력해보자.
SELECT empno, ename, job, SUBSTRING(hiredate,1,INSTR(hiredate,'-')-1) as hireyear
FROM emp
;


-- SQL 함수 
--   3) 숫자함수
-- 		- ROUND : 반올림
-- 		- CEIL : 올림 (소수점 자리 제거)
-- 		- FLOOR : 내림 (소수점 자리 제거)
-- 		- POW : 거듭제곱
-- 		- ABS : 절대값
-- 		- MOD : 나머지
-- 		- GREATEST : 최대값
-- 		- LEAST : 최솟값
-- 		- INTERVAL : 위치값

-- 	예문) emp테이블에서 사원들의 정보를 사번, 이름, 급여 그리고
-- 		급여의 십의 자리에서 반올림을 시켜 출력하자.
SELECT empno, ename, sal, ROUND(sal,-2) as roundSal
FROM emp
;

--  예문) emp테이블에서 사원들의 정보를 사번, 이름, 급여 그리고
--  	급여를 12로 나눴을 때 나머지가 얼마인지 출력
SELECT empno, ename, CEIL(sal), FLOOR(MOD(sal,12)) as salMod12
FROM emp
;

SELECT FLOOR(9.9), CEIL(9.1), ROUND(9.4), ROUND(9.6) -- 내림, 올림, 반올림 예제
;


--    4) 날짜 함수
-- 		- weekday() : 해당 날짜의 요일 (월요일 - 0 / 화요일  - 1 / ... / 일요일 - 6)
-- 		- dayofweek() : 그 주의 요일 (일요일 - 1 / 월요일 - 2 / ... / 토요일 - 7)
-- 		- now() : 현재 날짜 || Orcale의 경우: SYSDATE
-- 		- dayofmonth(날짜) : 그 달의 몇 번째 날인지 (일요일 - 1 / 월요일 - 2 / ... / 토요일 - 7)
-- 		- dayofweek(날짜) : 그 해의 몇 번째 날인지 (일요일 - 1 / 월요일 - 2 / ... / 토요일 - 7)
-- 		- month(날짜) : 해당 날짜의 월 반환
-- 		- year(날짜) : 해당 날짜의 년도 반환
-- 		- dayname(날짜) : 한 주의 요일명
-- 		- monthname(날짜): 월 이름
-- 		- quarter(날짜) : 분기 반환(1~4)
-- 

SELECT dayofweek('2024-04-15'), weekday('2024-04-15')
;

SELECT now(), dayofweek(now()), dayofmonth(now()), dayofyear(now())
;

SELECT now(), year(now()), month(now()), monthname(now()), day(now()), dayname(now()), quarter(now());


--   5) 시간 함수
--     - hour(시간) : 시 반환 (0~23)
--     - minute(시간) : 분 반환 (0~59)
--     - second(시간) : 초 반환 (0~59)

--     - period_add(날짜, 더할 월 수) : 지정한 날짜에서 더한 월의 날짜
--     - period_diff(날짜1, 날짜2) : 두 날짜사이의 개월 수

SELECT now(), hour(now()), minute(now()), second(now())
;

-- 예) 2024년 08월에서 5개월 뒤 / 24년 11월과 24년 5월의 개월 수
SELECT period_add(2408,5), period_diff(2411,2405), period_diff(2405, 2411)
;

-- 문제) emp테이블에서 각 사원들의 정보를 사번, 이름, 직종,
-- 		입사일, 현재날짜, 근무개월수 순으로 출력하시오.

SELECT empno, ename, job, hiredate, now(), period_diff(concat(year(now()), substring(now(),6,2)),concat(year(hiredate),substring(hiredate,6,2))) as workmonth
FROM emp
;

SELECT empno, ename, job, hiredate+0 as hiredate, LEFT(now()+0,8) as now, period_diff(LEFT(now()+0,6),LEFT(hiredate+0,6)) as workmonth
FROM emp
;

-- 년도와 월 사이에 0을 넣어주기 위해 년도에 100을 곱함
SELECT year(now())*100, month(now()), year(now())*100 + month(now())
;

SELECT empno, ename, job, hiredate, now(), period_diff((year(now())*100) + month(now()),(year(hiredate)*100) + month(hiredate)) as workmonth
FROM emp
;

-- date_format(날짜, 형식)
--   : 형식은 정해지는 것에 따라 날짜 또는 시간을 출력한다.

--   [형식] 
-- 		'%m' : 월 이름
-- 		'%w' : 요일 명
-- 		'%d' : 일 (며칠)
-- 		'%Y' : 연도 (4자리)
-- 		'%y' : 연도 (2자리)
-- 		'%H' : 시 (24시 형식)
-- 		'%h' : 시 (12시 형식)
-- 		'%i' : 분 (0~59분)
-- 		'%s' : 초 (0~59초)

SELECT now(), date_format(now(),'%Y/%m/%d') as c_date, date_format(now(),'%H:%i:%s') as c_time
;

SELECT now(), date_format(now(),'%Y/%m/%d') as now, date_format(now(),'%y%m') as now2, date_format(hiredate,'%y%m') as hiredate
FROM emp
;

-- 문제) emp테이블에서 각 사원들의 근무 월수를 알고자 한다.
--      사원들의 정보들 중 사번, 이름, 입사일, 근무월수 순으로
-- 		출력하자. 단, date_format을 사용하여 결과를 얻자.
SELECT empno, ename, hiredate, date_format(now(),'%Y-%m-%d') as today, period_diff(date_format(now(),'%y%m'),date_format(hiredate,'%y%m')) as workmonth
FROM emp
;



-- 자료형과 데이터 형변환
--   - 자료형
--     * VARCHAR 또는 CHAR : 문자열 
--     * TEXT, MIDIUMTEXT, LONGTEXT : 문자열
--     * INT : 숫자
--     * UNSIGNED : 양수
--     * SIGNED : 양수 + 음수
--     * DECIMAL : 고정소수섬
--     * FLOAT, DOUBLE : 부동소수점
--     * DATETIME, TIMESTAMP : 날짜 및 시간
--     * INT : 숫자


--   - 암시적 형변환
--  	* 날짜 자료형의 값들은 자동으로 문자열로 변환
-- 		* '1200'과 같은 숫자가 문자열로 된 자원들은 숫자로 자동으로 변환됨
-- 		* 1200과 같은 숫자가 문자열로 자동 변환됨

--   - 명시적 형변환
-- 		- SQL문장 내에서 변환함수를 사용하여 특정 자원을 원하는 자료형으로 변환
-- 		예) * DATE_FORMAT 함수를 이용한 경우
SELECT CAST('100' as UNSIGNED) as num
;



-- 데이터 그룹화
--  지금까지는 emp테이블 자체가 하나의 그룹이었고
--  이제는 emp테이블에서 소그룹을 만들어 결과를 소그룹별로 얻고자 할 때
--  그룹생성법을 알아야 가능하다.

-- 예) 각 부서별 급여의 평균과 총액을 구하라
-- 위와 같은 특정 값으로 자원들을 묶어서 그룹화 하여 처리할 때 GROUP BY 절을 사용한다.

SELECT deptno, COUNT(*), SUM(sal), ROUND(AVG(sal),-2)
FROM emp
GROUP BY deptno
ORDER BY deptno
;

SELECT deptno, COUNT(*), MAX(sal), MIN(sal)
FROM emp
GROUP BY deptno
;


-- 문제) 직종별 급여의 합과 평균을 구하시오.
SELECT job, COUNT(*), FLOOR(SUM(sal)), FLOOR(AVG(sal))
FROM emp
GROUP BY job
ORDER BY 2 ASC, 4 DESC
;

-- 문제) emp테이블에서 각 부서별 보너스(comm)의 합, 평균, 인원수를 출력
SELECT deptno, SUM(IFNULL(comm,0)), AVG(IFNULL(comm,0)), COUNT(*)
FROM emp
GROUP BY deptno
;

-- NULL값을 다른 값으로 대체할 때는 IFNULL사용 < Oracle은 NVL함수 사용
-- 만약! 특정 부서의 인원들 중에서 3명이 보너스를 받지 못하여 보너스 컬럼에 NULL이 있었다면
-- 평균을 구할 때는 그 3명은 평균을 구하는 연산에서 제외된다. 그렇지 않고 전체 인원으로 평균을 구해야한다면 
-- IFNULL로 NULL값을 0으로 대체하여 연산에 참여할 수 있도록 할 수 있다.



-- 예문) emp테이블에서 연봉을 계산하는 SELECT문장을 기술해보자. (급여 * 보너스)

SELECT *, sal*IFNULL(comm,0)
FROM emp
;

-- 예문) 분석가들의 급여 평균을 구하시오.

SELECT AVG(sal)
FROM emp
WHERE job = 'ANALYST'
;

SELECT AVG(sal)
FROM emp
GROUP BY job
HAVING job = 'ANALYST'
;

SELECT AVG(sal)
FROM emp
WHERE job = 'ANALYST'
GROUP BY job
;

SELECT job, SUM(sal), AVG(sal), count(*)
FROM emp
GROUP BY job
;


-- 예문) emp테이블에서 직종이 'CLERK' 또는 'SALESMAN'인 사원들 중 최대급여를 구하는 SELECT문은?
SELECT MAX(sal)
FROM emp
WHERE job IN ('CLERK','SALESMAN') -- WHERE job = 'CLERK' OR job = 'SALESMAN'
;

-- 예문) emp테이블에서 20부서의 최소급여를 출력하는 SELECT문은?
SELECT MIN(sal)
FROM emp
WHERE deptno = 20
;

-- 예문) emp테이블에서 각 부서별 인원수를 구하는 SELECT문은?
SELECT deptno, COUNT(*)
FROM emp
GROUP BY deptno
ORDER BY deptno
;

-- 예문) emp테이블에서 각 부서별 인원수를 구하는 SELECT문은?
--    단, 출력은 5명 이상인 부서만 출력해야한다.
SELECT deptno, COUNT(*) as empCnt
FROM emp
GROUP BY deptno
HAVING empCnt >= 5
ORDER BY deptno
;
-- 조건식에 그룹함수가 들어가있으면 HAVING절에 작성해야한다.
-- HAVING절의 위치는 GROUP BY 뒤에 작성해야한다.




-- ====================| 2024.04.15 PM |=========================

-- 문제) 각 부서 별 보너스의 합을 구하여 부서코드, 인원수,
-- 		보너스의 합 순으로 정보를 나타내는 SELECT문을 정의하시오.
-- 		단, NULL이 출력돼서는 안된다.

SELECT deptno, COUNT(*), FLOOR(SUM(IFNULL(comm,0)))
FROM emp
GROUP BY deptno
ORDER BY deptno ASC;
;


-- 문제) deptno가 20인 부서의 도시명을 출력하는 SELECT문을 정의하시오.

SELECT deptno, loc_code
FROM dept
WHERE deptno = 20
;

-- 기본키와 달리 참조적인 성격인 외래키는 해당 테이블에 있을 수도 없을 수도 있으며 중복이 가능하다.
-- 그래서 외래키의 경우 외래키를 제공하는 참조테이블과 외래키를 사용하는 테이블의 관계는 일대다(1:N)관계.
-- 
-- 참조무결성 규칙이란? 참조하는 테이블에 없는 데이터를 사용하는 것. 예를 들어, 참조테이블에 10,20,30만 있다면 40은 쓰지 못한다는 것.
-- 참조무결성강화조치
-- 

SELECT deptno, loc_code
FROM dept
WHERE deptno = 20
;

-- 위에서 얻어진 loc_code 값이 2번이라는 것을 확인
-- 이를 이용하여 아래와 같은 SQL문장을 다시 수행
SELECT *
FROM locations
WHERE loc_Code = 2;

-- 위는 두 번의 걸쳐 DB를 수행했으므로 시간적으로 유익하지 못 한 결과로 판단된다.
-- 이런 점을 해결하기 위해 서브쿼리를 학습할 것이다.

-- SUBQUERY
--    특정 SQL문장 안에 또 다른 SQL문장이 포함된 것

-- [장점] DB에 여러 번 접속해야하는 상황을 한번에 처리가 가능하게 해준다.
-- 		 한마디로 DB접속되는 횟수를 줄이고, 속도를 증가시킨다.

-- 	  - 서브쿼리를 사용할 수 있는 곳
-- 		* WHERE, HAVING
-- 		* INSERT구문의 INTO
-- 		* UPDATE구문의 SET 절
-- 		* SELECT나 DELETE 구문의 FROM

-- 	  예문) emp테이블에서 사원 이름이 'SMITH'이고, 직종이 'CLERK'인  
-- 		   사원의 급여보다 더 많이 받는 사원들의 정보를
--         사번, 이름, 직종, 급여 순으로 출력해보자!

--  [풀이]
--  1) 먼저 사원의 이름이 'SMITH'이고 직종이 'CLERK'인 사원의 급여를 알아내야 한다.
SELECT sal
FROM emp
WHERE UPPER(ename) = 'ALLEN' AND UPPER(job) = 'SALESMAN'
;

-- 2) 1)의 결과를 가지고 조건으로 건 다음의 문장을 만든다.
SELECT empno, ename, job, sal
FROM emp
WHERE sal > 1600;

-- 위의 1)과 2)를 각각 한번씩 두번을 DB에 접속한 경우다.
-- 이것을 서브쿼리를 활용하여 수행하면 1번에 끝난다.

SELECT empno, ename, job, sal
FROM emp
WHERE sal >	(
			 SELECT sal
			 FROM emp
			 WHERE UPPER(ename) = 'ALLEN' AND UPPER(job) = 'SALESMAN'
);

-- 문제) emp테이블에서 7521번 사원의 직종과 같고, 7844번 사원의 급여보다 많이 받는 
-- 		사원들의 정보를 사번, 이름,직종, 급여, 입사일 순으로 출력하라.

SELECT empno, ename, job, sal, hiredate
FROM emp
WHERE job = (SELECT job
			 FROM emp
			 WHERE empno = '7521') 
	  AND
	  sal > (SELECT sal
			 FROM emp
			 WHERE empno = '7844')
;

-- 1) 사번이 7521번인 사원의 직종 검색
SELECT job
FROM emp
WHERE empno = 7521
;

-- 2) 사번이 7844번인 사원의 급여 검색
SELECT sal
FROM emp
WHERE empno = 7844
;

-- 위의 결과를 조건으로 하는 문장
SELECT empno, ename, job, sal, hiredate
FROM emp
WHERE sal > (SELECT sal
			 FROM emp
             WHERE empno = 7844)
AND job = (SELECT job
		   FROM emp
           WHERE empno = 7521)
;

-- 문제) emp테이블에서 급여가 3000이상인 사원들 중
-- 입사일이 1982년 이전에 입사한 사원들의 정보를
-- 사번, 이름, 급여, 입사일 순으로 출력하라
SELECT empno, ename, sal, hiredate
FROM emp
WHERE empno IN (SELECT empno
				FROM emp
                WHERE sal >= 3000)
	  AND
      year(hiredate) < '1982'
;

SELECT empno, ename, sal, hiredate
FROM (SELECT *
	  FROM emp
      WHERE sal >= 3000) as sal3000
WHERE year(hiredate) < '1982'
;

SELECT empno, ename, sal, hiredate -- 가장 나중에 수행된다.
FROM emp -- 가장 먼저 수행된다.
WHERE hiredate < '1982-01-01'
	AND sal >= 3000 -- 그 다음 조건이 수행된다.
;
-- 위는 emp테이블 전체를 대상으로 검색을 수행한다.
-- 하지만 아래는 그렇지 않다.
SELECT a.empno, a.ename, a.sal, a.hiredate
FROM (SELECT *
	  FROM emp
      WHERE sal >= 3000) as a
WHERE year(a.hiredate) < '1982'
;

SELECT a.empno, a.ename, a.job, a.sal, a.hiredate
FROM 	(SELECT *
		 FROM emp
		 WHERE sal > (SELECT sal
					  FROM emp
					  WHERE empno = 7844
					 )
		) as a
WHERE a.job = (SELECT job
		   FROM emp
           WHERE empno = 7521)
;

-- 예) 급여가 3000이상인 사원들의 부서코드와 부서명을 출력하라.

-- 먼저 급여가 3000이상인 사원들의 부서코드 알아내기
SELECT deptno
FROM emp
WHERE sal >= 3000;

-- 앞서 구한 10, 20번을 가지고 dept테이블에서 
-- 조건으로 사용하여 SQL문장을 완성하라.
SELECT deptno, dname
FROM dept
WHERE deptno IN (10,20)
;

-- 서브쿼리 활용 예문
SELECT deptno, dname
FROM dept
WHERE deptno IN (SELECT distinct deptno
				 FROM emp
                 WHERE sal >= 3000)
;



-- 조인(JOIN)
--  데이터베이스의 테이블들 간 결합을 의미한다.
--  물리적 조인 : 기본키와 외래키를 통해서 테이블들을 결합하는 것 
-- 

SELECT distinct dept.deptno, dname -- distnct: 결과에서 중복을 제거할 수 있는 방법
FROM emp, dept
WHERE sal >= 3000 and emp.deptno = dept.deptno
;




-- 
-- 
-- 
-- 
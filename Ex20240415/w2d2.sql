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
-- 
-- 
-- 
-- 
-- 
-- 













-- ====================| 2024.04.15 PM |=========================

#!/bin/bash

#Info about my computer science students from students database

echo  -e "\n~~ My Computer Science Students ~~\n"

PSQL="psql -X --username=freecodecamp --dbname=students --no-align --tuples-only -c"

echo -e "\nFirst name, last name, and GPA of students with a 4.0 GPA:"
echo "$($PSQL "select first_name, last_name, gpa from students where gpa=4.0")"

echo -e "\nAll course names whose first letter is before 'D' in the alphabet:"
echo -e "\n$($PSQL "select course from courses where course < 'D'")"

echo -e "\nFirst name, last name, and GPA of students whose last name begins with an 'R' or after and have a GPA greater than 3.8 or less than 2.0:"
echo -e "\n$($PSQL "select first_name, last_name, gpa from students where last_name >= 'R' and (gpa > 3.8 or gpa < 2.0)")"

echo -e "\nLast name of students whose last name contains a case insensitive 'sa' or have an 'r' as the second to last letter:"
echo -e "\n$($PSQL "select last_name from students where last_name ilike '%sa%' or last_name ilike '%r_'")"

echo -e "\nFirst name, last name, and GPA of students who have not selected a major and either their first name begins with 'D' or they have a GPA greater than 3.0:"
echo -e "\n$($PSQL "select first_name, last_name, gpa from students where major_id is null and (first_name like 'D%' or gpa > 3.0)")"

echo -e "\nCourse name of the first five courses, in reverse alphabetical order, that have an 'e' as the second letter or end with an 's':"
echo -e "\n$($PSQL "select course from courses where course like '_e%' or course like '%s' order by course desc limit 5")"

echo -e "\nAverage GPA of all students rounded to two decimal places:"
echo -e "\n$($PSQL "select round(avg(gpa),2) from students")"

echo -e "\nMajor ID, total number of students in a column named 'number_of_students', and average GPA rounded to two decimal places in a column name 'average_gpa', for each major ID in the students table having a student count greater than 1:"
echo -e "\n$($PSQL "select major_id, count(*) as number_of_students, round(avg(gpa),2) as average_gpa from students group by major_id having count(*) > 1")"

echo -e "\nList of majors, in alphabetical order, that either no student is taking or has a student whose first name contains a case insensitive 'ma':"
echo -e "\n$($PSQL "select major from students right join majors on students.major_id = majors.major_id where student_id is null or first_name ilike '%ma%' order by major")"

echo -e "\nList of unique courses, in reverse alphabetical order, that no student or 'Obie Hilpert' is taking:"
echo -e "\n$($PSQL "select distinct(course) from courses full join majors_courses using(course_id) full join majors using (major_id) full join students using (major_id) where student_id is null or (first_name = 'Obie' and last_name = 'Hilpert') order by course desc")"

echo -e "\nList of courses, in alphabetical order, with only one student enrolled:"
echo -e "\n$($PSQL "select course from courses full join majors_courses using(course_id) full join majors using(major_id) full join students using(major_id) group by course having count(student_id) = 1 order by course")"
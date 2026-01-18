8. BONUS: Selezionare per ogni studente quanti tentativi d esame ha sostenuto per
superare ciascuno dei suoi esami

    
    SELECT 
        students.id, 
        students.name, 
        students.surname, 
        courses.name AS course_name,
        COUNT(*) AS attempts,
        MAX(exam_student.vote) AS best_vote
    FROM students
    INNER JOIN exam_student
    ON students.id = exam_student.student_id
    INNER JOIN exams
    ON exam_student.exam_id = exams.id
    INNER JOIN courses
    ON exams.course_id = courses.id
    GROUP BY students.id, students.name, students.surname, courses.id, courses.name
    ORDER BY students.id, courses.name;
   

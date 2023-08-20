package com.techapoorva.student.repositories;

import com.techapoorva.student.entities.Student;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 * @author Apoorva Raj
 * @email apoorvaraj47@gmail.com
 * @linkedin devapoorva
 */
@Repository
public interface StudentRepository extends JpaRepository<Student,Long> {
    Student findByEmail(String email);

}

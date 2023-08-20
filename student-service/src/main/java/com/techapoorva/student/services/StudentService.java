package com.techapoorva.student.services;

import com.techapoorva.student.dto.StudentDto;
import com.techapoorva.student.entities.Student;

/**
 * @author Apoorva Raj
 * @email apoorvaraj47@gmail.com
 * @linkedin devapoorva
 */
public interface StudentService {
    Student create(StudentDto studentDto);
}

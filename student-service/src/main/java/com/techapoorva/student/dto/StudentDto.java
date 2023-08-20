package com.techapoorva.student.dto;

import com.techapoorva.student.entities.Student;
import lombok.Builder;

import java.time.Instant;

/**
 * @author Apoorva Raj
 * @email apoorvaraj47@gmail.com
 * @linkedin devapoorva
 */
@Builder
public class StudentDto {
    private String email;
    private String name;
    private String father;
    private long id;

    public Student toEntity(){
        return Student.builder()
                .id(id)
                .name(name)
                .email(email)
                .father(father)
                .updatedAt(Instant.now())
                .build();
    }
}

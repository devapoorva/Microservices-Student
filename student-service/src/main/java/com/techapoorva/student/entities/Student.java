package com.techapoorva.student.entities;

import jakarta.persistence.*;
import lombok.*;

import java.time.Instant;

/**
 * @author Apoorva Raj
 * @email apoorvaraj47@gmail.com
 * @linkedin devapoorva
 */
@Entity
@Table(
        name = "students",
        uniqueConstraints = @UniqueConstraint(
                name = "students_unique_email",
                columnNames = "email_address"
        )
)
@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Student {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    private String name;

    @Column(name = "email_address")
    private String email;

    private String father;

    private Instant createdAt;
    private Instant updatedAt;
}

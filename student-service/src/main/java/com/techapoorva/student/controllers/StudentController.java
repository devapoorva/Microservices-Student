package com.techapoorva.student.controllers;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author Apoorva Raj
 * @email apoorvaraj47@gmail.com
 * @linkedin devapoorva
 */
@RestController
@RequestMapping(path = "api/v1/student")
public class StudentController {

    @GetMapping(path = "/")
    public String index(){
        return "student service";
    }
}


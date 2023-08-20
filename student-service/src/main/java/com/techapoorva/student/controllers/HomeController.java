package com.techapoorva.student.controllers;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author Apoorva Raj
 * @email apoorvaraj47@gmail.com
 * @linkedin devapoorva
 */
@RestController
public class HomeController {

    @GetMapping(path = "/")
    public String index(){
        return "Student Service running";
    }


}

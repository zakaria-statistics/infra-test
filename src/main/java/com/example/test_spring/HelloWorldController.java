package com.example.test_spring;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;


@RestController
public class HelloWorldController {

    @GetMapping("/hello")
    public String hello() {
        return "Hello, Kaniko!";
    }
}

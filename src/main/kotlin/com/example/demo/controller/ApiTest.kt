package com.example.demo.controller

import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController


@RestController
class ApiTest {

    @GetMapping("/test")
    fun test(): ResponseEntity<Any> {
        return ResponseEntity("test ok plus", HttpStatus.OK)
    }
}
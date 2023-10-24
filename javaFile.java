package org.company.application.simplespringbootapp;

import org.springframework.boot.*;
import org.springframework.boot.autoconfigure.*;
import org.springframework.web.bind.annotation.*;

//@SpringBootApplication
@RestController
@EnableAutoConfiguration
public class Main {
	
	@GetMapping( value= "/" )
	@ResponseBody 
	public String home(@RequestParam(required=false) String name, @RequestParam(required=false) String phone ) {
		return "Hello " + sanitizers.sanitize(name) + "! We will contact you at " + sanitizers.sanitizePhone(phone) + " shortly.";
		
	}

    public static void main(String[] args) {
        SpringApplication.run(Main.class, args);
    }
}
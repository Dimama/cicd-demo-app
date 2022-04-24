package cicd.app;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication(scanBasePackages = { "cicd.app" })
public class HelloWorldApplication {
    
    public static void main(String[] args) {
        SpringApplication.run(HelloWorldApplication.class, args);
    }
}

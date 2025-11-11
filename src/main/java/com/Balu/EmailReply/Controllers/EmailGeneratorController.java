package com.Balu.EmailReply.Controllers;

import com.Balu.EmailReply.EmailRequest.EmailRequest;
import com.Balu.EmailReply.Services.EmailGeneratorService;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@CrossOrigin("*")
@RestController
@RequestMapping("api/email")
@AllArgsConstructor

public class EmailGeneratorController {

    private final EmailGeneratorService emailGeneratorService;



    @PostMapping("/generate")
    public ResponseEntity<String> generateEmail(@RequestBody EmailRequest emailRequest){
        String response=emailGeneratorService.generateEmailReply(emailRequest);
        return ResponseEntity.ok(response);

    }

}

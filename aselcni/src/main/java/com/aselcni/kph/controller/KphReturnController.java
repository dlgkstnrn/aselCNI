package com.aselcni.kph.controller;

import org.springframework.stereotype.Controller;

import com.aselcni.kph.service.KphReturnService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class KphReturnController {

	private final KphReturnService kphReturnService; 
	
}

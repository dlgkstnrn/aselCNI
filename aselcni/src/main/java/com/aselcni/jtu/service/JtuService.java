package com.aselcni.jtu.service;

import org.springframework.stereotype.Service;

import com.aselcni.jtu.dao.JtuDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class JtuService {
	private final JtuDao jtuDao;
	

}

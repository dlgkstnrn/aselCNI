package com.aselcni.kph.service;

import org.springframework.stereotype.Service;

import com.aselcni.kph.dao.KphReturnDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class KphReturnServiceImp implements KphReturnService {

	private final KphReturnDao kphReturnDao;
	
}

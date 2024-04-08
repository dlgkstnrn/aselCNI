package com.aselcni.lhs.service;

import org.springframework.stereotype.Service;

import com.aselcni.lhs.dao.CompmstDao;
import com.aselcni.lhs.model.Compmst;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CompmstServiceImpl implements CompmstService {

	private final CompmstDao compmstDao;
	
	@Override
	public int compmstUpdate(Compmst compmst) {
		return compmstDao.compmstUpdate(compmst);
	}
	
	@Override
	public Compmst compmstSelect() {
		return compmstDao.compmstSelect();
	}

}

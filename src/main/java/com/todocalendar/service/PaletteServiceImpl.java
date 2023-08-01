package com.todocalendar.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.todocalendar.mapper.PaletteMapper;
import com.todocalendar.model.PaletteVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class PaletteServiceImpl implements PaletteService {

	@Autowired
	private PaletteMapper paletteMapper;

	@Override
	public List<PaletteVO> selectPaletteList(PaletteVO palette) {
		log.info("Service :: selectPaletteList...................");
		return paletteMapper.selectPaletteList(palette);
	}
	
	@Override
	public List<PaletteVO> selectPaletteListAll() {
		log.info("Service :: selectPaletteList...................");
		return paletteMapper.selectPaletteListAll();
	}

}

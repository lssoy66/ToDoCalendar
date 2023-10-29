
package com.todocalendar.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.todocalendar.mapper.MemberMapper;
import com.todocalendar.model.MemberVO;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class MemberServiceImpl implements MemberService {
	
	@Autowired
//	@Setter(onMethod = @Autowired)
	MemberMapper memberMapper;
	
	@Override
	public void insertMember(MemberVO member) {
		log.info("insertMember.........");
		memberMapper.insertMember(member);
	}
	
	@Override
	public MemberVO readById(String id) {
		log.info("readById........." + id);
		return memberMapper.readById(id);
	}
	
	@Override
	public MemberVO loginCheck(MemberVO member) {
		log.info("loginCheck........." + member);
		return memberMapper.loginCheck(member);
	}
	
	@Override
	public void updatePassword(MemberVO member) {
		log.info("updateMember........." + member);
		memberMapper.updatePassword(member);
	}
	
	@Override
	public void withdrawMember(String id) {
		log.info("withdrawMember........." + id);
		memberMapper.withdrawMember(id);
	}
	
	@Override
	public MemberVO memberCheck(MemberVO member) {
		log.info("MemberCheck........." + member);
		return memberMapper.memberCheck(member);
	}
	
	@Override
	public void changeDelayAuto(String id, String delay_auto) {
		log.info("changeDelayAuto........." + id + ", " + delay_auto);
		memberMapper.changeDelayAuto(id, delay_auto);
	}
	
	@Override
	public void changeHoliday(String id, String holiday) {
		log.info("changeHoliday........." + id + ", " + holiday);
		memberMapper.changeHoliday(id, holiday);
	}
	
	@Override
	public List<MemberVO> selectMemberList(MemberVO member) {
		log.info("Service :: selectMemberList...................");
		return memberMapper.selectMemberList(member);
	}
	
	@Override
	public boolean selectId(String id) {
		log.info("Service :: selectId...................");
		return memberMapper.selectId(id);
	}
	
	@Override
	public String findId(String name, String email) {
		log.info("Service :: findId...................");
		return memberMapper.findId(name, email);
	}
	
	@Override
	public String findAccount(String id) {
		log.info("Service :: findAcount...................");		
		return memberMapper.findAccount(id);
	}
	
	@Override
	public void updateTempPassword(String id, String name, String email, String tempPassword) {
		log.info("Service :: updateTempPassword...................");
		memberMapper.updateTempPassword(id, name, email, tempPassword);
	}
}
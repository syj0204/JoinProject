package com.join.app;

import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 * Handles requests for the application home page.
 */
@Controller
public class MainController {
	
private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String main(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		return "main";
	}
	
	@RequestMapping(value = "/verify_captcha", method = RequestMethod.POST)
	public JSONObject join(@RequestParam(value="captcha_response") String captcha_response) {
		
		logger.info("captcha_response="+captcha_response);
		
		
		JSONObject result_json = null;
		HashMap<String, String> result_map = new HashMap<String, String>();
		CaptchaVerify capchaVerify = new CaptchaVerify();
		String r = capchaVerify.captcha_verify("https://www.google.com/recaptcha/api/siteverify?secret=6LesJhcUAAAAAPJsP4OVkYtfxv7w_munJ9NR3hj7&response="+captcha_response);
		logger.info("r="+r);
		result_json = new JSONObject(r);
		logger.info("result="+result_json.get("success").toString());
		
		return result_json;
	}
	
	
	
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String join(@ModelAttribute User user, BindingResult result, Model model) {
		String imgsrc = user.getImgsrc().trim();
		String name = user.getName().trim();
		String road_name_address = user.getRoad_name_address().trim();
		String detail_address = user.getDetail_address().trim();
		String lot_number = user.getLot_number().trim();
		String post_code = user.getPost_code().trim();
		String phone = user.getPhone().trim();
		String email = user.getEmail().trim();
		String joinpath = user.getJoinpath();
		String interests = user.getInterests();
		String captcha_response = user.getCaptcha_response();
		logger.info("imgsrc="+imgsrc);
		logger.info("captcha_response="+captcha_response);
		
		JSONObject result_json = null;
		//HashMap<String, String> result_map = new HashMap<String, String>();
		
		CaptchaVerify capchaVerify = new CaptchaVerify();
		String verify_result = capchaVerify.captcha_verify("https://www.google.com/recaptcha/api/siteverify?secret=6LesJhcUAAAAAPJsP4OVkYtfxv7w_munJ9NR3hj7&response="+captcha_response);
		logger.info("verify_result="+verify_result);
		result_json = new JSONObject(verify_result);
		//result_map.put("success", result_json.get("success").toString());
		logger.info("result_map="+result_json.get("success").toString());
		
		String is_success = result_json.get("success").toString();
		ModelAndView mav = null;
		String view = "";
		
		if(is_success=="true") {
			model.addAttribute("name", name);
			model.addAttribute("name", name);
			model.addAttribute("name", name);
			model.addAttribute("name", name);
			model.addAttribute("name", name);
			
			mav = new ModelAndView("main");
            mav.addObject("name", name);
            mav.addObject("phone", phone);
            mav.addObject("email", email);
            mav.addObject("joinpath", joinpath);
            mav.addObject("interests", interests);
            view = "redirect:/join_success";
		} else {
			mav = new ModelAndView("join_fail");
			view = "redirect:/join_fail";
		}
		return view;
	}
	
	@RequestMapping(value = "/join_success")
	public String join_success() {
		
		logger.info("join_success");
		
		return "join_success";
	}
	
	@RequestMapping(value = "/join_fail")
	public String join_fail() {
		
		logger.info("join_fail");
		
		return "join_fail";
	}
	
}

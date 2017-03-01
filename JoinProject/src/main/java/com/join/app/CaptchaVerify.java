package com.join.app;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;

public class CaptchaVerify {
	public String captcha_verify(String verify_url) {
		URL url = null;
		String inputLine = "";
		StringBuffer contents = new StringBuffer();
		//JSONObject result_json = null;
		//HashMap<String, String> result_map = new HashMap<String, String>();

		try {
			// get URL content
			url = new URL(verify_url);
			URLConnection conn = url.openConnection();

			// open the stream and put it into BufferedReader
			BufferedReader br = new BufferedReader(
                               new InputStreamReader(conn.getInputStream()));

			while ((inputLine = br.readLine()) != null) {
				contents.append(inputLine);
			}

			br.close();
			//System.out.println(contents.toString());
			//result_json = new JSONObject(contents.toString());
			//result_map.put("success", result_json.get("success").toString());

			System.out.println(br.toString());

		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return contents.toString();
	}

}

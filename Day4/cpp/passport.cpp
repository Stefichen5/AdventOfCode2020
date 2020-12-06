//
// Created by stefan on 06.12.20.
//

#include <iostream>
#include <algorithm>
#include "passport.h"

passport::passport(std::string * data) {
	std::string local_data(*data);
	local_data.erase(local_data.size()-1,1);
	std::replace(local_data.begin(), local_data.end(), ' ', ';');

	bool done = false;
	while (!done){
		std::string key_val_pair = local_data.substr(0, local_data.find(';'));
		std::string key = key_val_pair.substr(0, key_val_pair.find(':'));
		std::string val = key_val_pair.substr(key_val_pair.find(':')+1, key_val_pair.npos);

		if (local_data.find(';') != std::string::npos) {
			local_data.erase(0, local_data.find(';') + 1);
		} else{
			done = true;
		}

		if (local_data.length() < 2){done=true;}

		if(key == "byr" ){
			if (!add_byr(val)){
				is_valid = false;
			}
		} else if (key == "iyr" ){
			if (!add_iyr(val)){
				is_valid = false;
			}
		} else if (key == "eyr" ){
			if (!add_eyr(val)){
				is_valid = false;
			}
		} else if (key == "hgt" ){
			if (!add_hgt(val)){
				is_valid = false;
			}
		} else if (key == "hcl" ){
			if (!add_hcl(val)){
				is_valid = false;
			}
		} else if(key == "ecl" ){
			if (!add_ecl(val)){
				is_valid = false;
			}
		} else if(key == "pid" ){
			if (!add_pid(val)){
				is_valid = false;
			}
		}
	}
}

bool passport::add_byr(std::string &val) {
	has_byr = true;
	if (val == "" ){return false;}

	byr = std::stoi(val);

	if (byr >= 1920 && byr <= 2002){
		return true;
	}

	return false;
}

bool passport::get_valid() const {
	return has_all_fields() && is_valid;
}

bool passport::add_iyr(std::string &val) {
	has_iyr = true;
	if (val == "" ){return false;}

	iyr = std::stoi(val);

	if (iyr >= 2010 && iyr <= 2020){
		return true;
	}

	return false;
}

bool passport::add_eyr(std::string &val) {
	has_eyr =  true;
	if (val == "" ){return false;}

	eyr = std::stoi(val);

	if (eyr >= 2020 && eyr <= 2030){
		return true;
	}

	return false;
}

bool passport::add_hgt(std::string &val) {
	has_hgt = true;
	if (val == "" ){return false;}

	if (val.find("cm") == std::string::npos && val.find("in") == std::string::npos){
		return false;
	}

	if (val.find("cm") == std::string::npos){
		hgt_cm=false;
	}
	val = val.substr(0, val.size()-2);

	hgt = std::stoi(val);

	if ((hgt_cm && (hgt >= 150 && hgt <= 193))
	|| !hgt_cm && (hgt >= 59 && hgt <= 76) ){
		return true;
	}

	return false;
}

bool passport::add_hcl(std::string &val) {
	has_hcl = true;
	if (val == "" ){return false;}

	hcl = val;

	if(hcl.at(0) != '#'){
		return false;
	}
	if(hcl.size() != 7){
		return false;
	}

	if(val.substr(1,val.size()).find_first_not_of("abcdefghijklmnopqrstuvwxyz0123456789") != std::string::npos){
		return false;
	}

	return true;
}

bool passport::add_ecl(std::string &val) {
	has_ecl = true;
	if (val == "" ){return false;}

	ecl=val;

	if (ecl == "amb" || ecl == "blu" || ecl == "brn" || ecl == "gry" || ecl == "grn" || ecl == "hzl" || ecl =="oth"){
		return true;
	}

	return false;
}

bool passport::add_pid(std::string &val) {
	has_pid = true;
	if (val == "" ){return false;}
	pid = val;

	if (pid.length() != 9){ return false;}
	if (pid.find_first_not_of("0,123456789") != std::string::npos){
		return false;
	}

	return true;
}

bool passport::has_all_fields() const {
	return has_byr && has_iyr && has_eyr && has_hgt && has_hgt && has_hcl && has_ecl && has_pid;
}

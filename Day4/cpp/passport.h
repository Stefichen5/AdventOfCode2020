//
// Created by stefan on 06.12.20.
//

#ifndef CPP_PASSPORT_H
#define CPP_PASSPORT_H


#include <string>

class passport {
public:
	passport(std::string * data);
	~passport() = default;

	bool has_all_fields() const;
	bool get_valid() const;
private:
	bool has_byr = false;
	uint byr = 0;
	bool has_iyr = false;
	uint iyr = 0;
	bool has_eyr = false;
	uint eyr = 0;
	bool has_hgt = false;
	uint hgt = 0;
	bool hgt_cm = true;
	bool has_hcl = false;
	std::string hcl;
	bool has_ecl = false;
	std::string ecl;
	bool has_pid = false;
	std::string pid;
	bool is_valid = true;

	bool add_byr(std::string & val);
	bool add_iyr(std::string & val);
	bool add_eyr(std::string & val);
	bool add_hgt(std::string & val);
	bool add_hcl(std::string & val);
	bool add_ecl(std::string & val);
	bool add_pid(std::string & val);
};


#endif //CPP_PASSPORT_H

#include <iostream>
#include <fstream>
#include <algorithm>

struct password_policy{
	uint min = 0;
	uint max = 0;
	char letter = 0;
	std::string password;
};

void parse_password(std::string * full_line, password_policy * policy){
	if(full_line == nullptr || policy == nullptr) {return;}

	policy->min = std::stoi(full_line->substr(0, full_line->find('-')));
	policy->max = std::stoi(full_line->substr(full_line->find('-')+1, full_line->find(' ') - full_line->find('-')));
	policy->letter = full_line->substr(full_line->find(' '), 2).c_str()[1];
	policy->password = full_line->substr(full_line->find(": "), full_line->npos);
}

bool validate_password_part1(password_policy * policy){
	if (policy == nullptr) {return false;}

	uint occurrences = std::count(policy->password.cbegin(), policy->password.cend(), policy->letter);
	if(occurrences >= policy->min && occurrences <= policy->max){
		return true;
	}

	return false;
}

bool validate_password_part2(password_policy * policy){
	if (policy == nullptr) {return false;}

	char a = policy->password.at(policy->min+1);
	char b = policy->password.at(policy->max+1);

	if (a != b	&& ( a == policy->letter || b == policy->letter)){
		return true;
	}

	return false;
}

int main(int argc, char* argv[]) {
	if (argc < 2) {
		std::cout << "Please provide input file" << std::endl;
		return 1;
	}
	std::ifstream infile;
	infile.open(argv[1]);

	if (!infile.good()) {
		std::cout << "Could not open file" << std::endl;
		return 1;
	}

	std::string line;
	uint valid_passwords_1=0;
	uint valid_passwords_2=0;
	while (std::getline(infile, line)) {
		password_policy policy = {0};
		parse_password(& line, & policy);
		if (validate_password_part1(&policy)){
			valid_passwords_1++;
		}

		if (validate_password_part2(&policy)){
			valid_passwords_2++;
		}
	}
	infile.close();

	std::cout << "Valid passwords (part 1): " << valid_passwords_1 << std::endl;
	std::cout << "Valid passwords (part 2): " << valid_passwords_2 << std::endl;

	return 0;
}
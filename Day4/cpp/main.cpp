#include <iostream>
#include <fstream>
#include "passport.h"

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
	uint valid_1 = 0;
	uint valid_2 = 0;
	std::string passport_details;
	while (std::getline(infile, line)) {
		if(line.size() > 1){
			passport_details.append(line);
			passport_details.append(" ");
		} else{
			passport p(&passport_details);
			passport_details="";
			if (p.has_all_fields()){
				valid_1++;
			}
			if (p.get_valid()){
				valid_2++;
			}
		}
	}
	infile.close();

	std::cout << "Valid (part 1): " << valid_1 << std::endl;
	std::cout << "Valid (part 2): " << valid_2 << std::endl;

	return 0;
}

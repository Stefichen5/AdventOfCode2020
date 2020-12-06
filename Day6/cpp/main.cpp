#include <iostream>
#include <fstream>
#include <vector>
#include <unordered_map>

uint get_unique_chars(std::vector<std::string> * group){
	std::string all;

	for (auto & elem : *group){
		all.append(elem);
	}

	auto pos = std::string::npos;

	std::unordered_map<char, uint> map;

	for (int i = 0; i < all.length(); i++){
		map[all[i]]++;
	}

	uint size = map.size();

	return map.size();
}

uint get_common_yes(std::vector<std::string> * group){
	uint count = 0;
	std::string base = group->front();

	for(auto & c : base){
		bool everywhere = true;

		for (auto & elem : *group){
			if (elem.find(c) == std::string::npos){
				everywhere = false;
			}
		}

		if (everywhere){
			count++;
		}
	}

	return count;
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
	std::vector<std::string> group;
	uint total_yes = 0;
	uint common_yes = 0;
	while (std::getline(infile, line)) {
		if (line == ""){
			total_yes += get_unique_chars(&group);
			common_yes += get_common_yes(&group);
			group.clear();
		} else{
			group.push_back(line);
		}
	}
	total_yes += get_unique_chars(&group);
	common_yes += get_common_yes(&group);
	infile.close();

	std::cout << "Total unique yes (Part 1): " << total_yes << std::endl;
	std::cout << "Total common yes (Part 2): " << common_yes << std::endl;

	return 0;
}

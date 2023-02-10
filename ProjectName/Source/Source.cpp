#include<iostream>

#define FINDASSET(FilePath) CONTENT_PATH FilePath

int main(int argc, char* argv[])
{
    std::cout << "Application\n";
    std::cout << "Content Path: " << FINDASSET("Assets/MyAsset.asset") << "\n";
    system("pause");
    return 0;
}
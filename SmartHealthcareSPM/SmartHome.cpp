#include <iostream>
using namespace std;

class TemperatureController {
public:
    virtual void controlTemperature() = 0;
    virtual ~TemperatureController() {}
};

class LightingSystem {
public:
    virtual void controlLighting() = 0;
    virtual ~LightingSystem() {}
};

class SummerTemperatureController : public TemperatureController {
public:
    void controlTemperature() override {
        cout << "[Summer] Setting temperature to 24°C (Cooling ON)." << endl;
    }
};

class SummerLightingSystem : public LightingSystem {
public:
    void controlLighting() override {
        cout << "[Summer] Bright lights with cool tone." << endl;
    }
};

class WinterTemperatureController : public TemperatureController {
public:
    void controlTemperature() override {
        cout << "[Winter] Setting temperature to 20°C (Heating ON)." << endl;
    }
};

class WinterLightingSystem : public LightingSystem {
public:
    void controlLighting() override {
        cout << "[Winter] Warm lights for cozy environment." << endl;
    }
};

class SmartHomeFactory {
public:
    virtual TemperatureController* createTemperatureController() = 0;
    virtual LightingSystem* createLightingSystem() = 0;
    virtual ~SmartHomeFactory() {}
};

class SummerFactory : public SmartHomeFactory {
public:
    TemperatureController* createTemperatureController() override {
        return new SummerTemperatureController();
    }

    LightingSystem* createLightingSystem() override {
        return new SummerLightingSystem();
    }
};

class WinterFactory : public SmartHomeFactory {
public:
    TemperatureController* createTemperatureController() override {
        return new WinterTemperatureController();
    }

    LightingSystem* createLightingSystem() override {
        return new WinterLightingSystem();
    }
};

int main() {
    int choice;

    cout << "Select Mode (1 = Summer, 2 = Winter): ";
    cin >> choice;

    SmartHomeFactory* factory = nullptr;

    if (choice == 1) {
        factory = new SummerFactory();
    } else if (choice == 2) {
        factory = new WinterFactory();
    } else {
        cout << "Invalid choice!" << endl;
        return 0;
    }

    TemperatureController* tempController =
        factory->createTemperatureController();

    LightingSystem* lightingSystem =
        factory->createLightingSystem();

    tempController->controlTemperature();
    lightingSystem->controlLighting();

    delete tempController;
    delete lightingSystem;
    delete factory;

    return 0;
}
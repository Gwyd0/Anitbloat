import json
import subprocess


class d:
    v = "1.0.2 - Python"
    EDR = 1  # 0=enableing apps 1=disbaling apps 2=removing apps

    RED = "\033[31m"
    GREEN = "\033[32m"
    YELLOW = "\033[33m"
    BLUE = "\033[34m"
    PINK = "\033[35m"
    CYAN = "\033[36m"
    NORMAL = "\033[0;39m"

    NAME = "{0}[ANTIBLOAT]{1} ".format(CYAN, NORMAL)
    ERROR = "{0}[ERROR]{1} ".format(RED, NORMAL)
    SUCCESS = "{0}[SUCCESS]{1} ".format(GREEN, NORMAL)


def removebloatware(com, disable):
    with open("bloatware.json", "r") as read:
        data = json.load(read)

        for a in data["bloatware"][com]:
            app = a["package"]
            desc = a["desc"]

            if disable:
                a = input(d.NAME+"Would you like to Disable {0}{1}? {2}({3})\n>:".format(d.YELLOW,app,d.RED, desc))
            else:
                a = input(d.NAME+"Would you like to Remove {0}{1}? {2}({3})\n>:".format(d.YELLOW,app,d.RED, desc))

            if a.casefold() == "y":
                if disable:
                    print(d.NAME+"Disabling package {0}{1}".format(d.YELLOW, app))
                    adb_disable = subprocess.run(["adb", "-d", "shell", "pm", "disable-user", "--user", "0", app],
                                                 stdout=subprocess.DEVNULL, stderr=subprocess.STDOUT)
                    if not adb_disable.returncode == 0:
                        print(d.ERROR+"Could not Disable package {0}{1}".format(d.YELLOW, app))
                    else:
                        print(d.SUCCESS+"Disabled package {0}".format(app))
                else:
                    print(d.NAME+"Removing package {0}{1}".format(d.YELLOW, app))
                    adb_disable = subprocess.run(["adb", "-d", "shell", "pm", "uninstall", "--user", "0", app],
                                                 stdout=subprocess.DEVNULL, stderr=subprocess.STDOUT)
                    if not adb_disable.returncode == 0:
                        print(d.ERROR+"Could not Remove package {0}{1}".format(d.YELLOW, app))
                    else:
                        print(d.SUCCESS+"Removed package {0}".format(app))

            elif a.casefold() == "n":
                print(d.NAME+"Skipping Package")
            else:
                print(d.ERROR+"Invalid Argument Skipping..")

            print("\n{0}----------------{1}\n".format(d.CYAN,d.NORMAL))


print(d.NAME + d.v)
print("{0}By{1} Gwyd{2} Github:{3} https://github.com/Gwyd0/Anitbloat{4}\n{0}Connecting to device using ADB{1} Make"
      " sure you have ADB installed and a device connected via USB with USB debugging enabled{4}".format(d.NAME,
                                                                                                         d.CYAN,
                                                                                                         d.GREEN,
                                                                                                         d.PINK,
                                                                                                         d.NORMAL))
#print("\n{0}----------------{1}\n".format(d.CYAN,d.NORMAL))
#b = str(input(d.NAME+"Are you {0}enabling/disabling/removing apps?{1} (0,1,2)\n>:".format(d.CYAN,d.RED)))
#if b==0 or b==1 or b==2:
#    d.EDR = b
#    print(d.NAME+"You picked " + b)
#else:
#    print(d.ERROR+"Please pick (0,1,2) Going with default (Disabling)")

print("\n{0}----------------{1}\n".format(d.CYAN,d.NORMAL))

removebloatware("huawei", True)
removebloatware("google", True)
removebloatware("amazon", True)
print(d.NAME+"Done! Removed/Disabled all bloatware.")
input(d.NAME+"Press any key to exit")
exit()

import os
import xml.etree.ElementTree
import pathlib


if __name__ == '__main__':
    file_name = "drivers.xml"
    if pathlib.Path(file_name).exists():
        print("temp file drivers.xml exists, exit!!!")
        exit()
    os.system('pnputil /enum-drivers /format xml /output-file drivers.xml')
    drivers = xml.etree.ElementTree.parse('drivers.xml').getroot()
    pathlib.Path(file_name).unlink()
    for driver in drivers:
        amd_related = False
        for element in driver:
            if element.tag == 'ProviderName' and (element.text == 'AMD' or element.text == 'Advanced Micro Devices, Inc.'):
                amd_related = True
        if amd_related:
            for element in driver:
                print(element.tag, ":", element.text)
            print("deleting it")
            os.system("pnputil /delete-driver {} /uninstall".format(driver.attrib['DriverName']))
            print("delete done\n\n")
    
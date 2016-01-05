import sys
from pynwn.module import Module

def output_data(areas):

    sorted_areas = sorted(areas, key=lambda k: k['name'])

    for area in sorted_areas:
        print(area['name'])
        waypoints = area['waypoints']

        if len(waypoints) > 0:
            print('\tWaypoints:')
            for w in waypoints:
                print('\t\t'+ w)

        print('')

def main():
    mod = Module(r'/home/tweek/nwn/modules/DH WIP 2.mod')
    #mod = Module('../events_demo.mod')

    areas = []

    for area in mod.areas:
        a_name = area.are['Name'].to_dict()['value']['0']
        a_dict = {
                'name': a_name,
                'waypoints': []
                }

        for w in area.waypoints:
            a_dict['waypoints'].append(w.tag)

        areas.append(a_dict)

    output_data(areas)

if __name__ == '__main__':
    main()
    sys.exit()

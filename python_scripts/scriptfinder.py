import sys

from pynwn.module import Module
from pynwn.scripts import Event

def output_data(areas):

    sorted_areas = sorted(areas, key=lambda k: k['name'])

    for area in sorted_areas:
        print(area['name'])
        doors = area['doors']
        placeables = area['placeables']
        triggers = area['triggers']
        waypoints = area['waypoints']

        if len(doors) > 0:
            print('\tDoors:')
            for d in doors:
                print_obj(d)

        if len(placeables) > 0:
            print('\tPlaceables:')
            for p in placeables:
                print_obj(p)

        if len(triggers) > 0:
            print('\tTriggers:')
            for t in triggers:
                print_obj(t)

        if len(waypoints) > 0:
            print('\tWaypoints:')
            for w in waypoints:
                print_obj(w)

def print_obj(obj):
    print('\t\t'+ obj['tag'])

    for event, script in obj['events']:
        print('\t\t\t' + event + ": " + script)

def get_data(obj):
    s_list = obj.scripts.all()
    has_scripts = False

    if len(s_list) > 0:
        if not has_scripts:
            has_scripts = True
        obj_dict = {
                'tag': obj.tag,
                'events': []
                }

        for s in s_list:
            event = dir(Event)[s[0]]
            s_name = s[1]
            obj_dict['events'].append((event, s_name))

    if has_scripts:
        return obj_dict
    return None


def main():
    mod = Module(r'/home/tweek/nwn/modules/DH WIP 2.mod')
    #mod = Module('../events_demo.mod')

    areas = []

    for area in mod.areas:
        a_name = area.are['Name'].to_dict()['value']['0']
        a_dict = {
                'name': a_name,
                'doors': [],
                'placeables': [],
                'triggers': [],
                'waypoints': []
                }

        for d in area.doors:
            d_data = get_data(d)
            if d_data:
                a_dict['doors'].append(d_data)

        for p in area.placeables:
            p_data = get_data(p)
            if p_data:
                a_dict['placeables'].append(p_data)

        areas.append(a_dict)

    output_data(areas)

if __name__ == '__main__':
    main()
    sys.exit()

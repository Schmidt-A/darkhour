import tailer
import os

day_rec     = {}
red_flags   = []
curr_day    = ''
naughty_d   = os.path.join(os.getcwd(), 'naughty-xp')
nice_d      = os.path.join(os.getcwd(), 'nice-xp')

def setup_dirs():
    if not os.path.exists(naughty_d):
        os.makedirs(naughty_d)

    if not os.path.exists(nice_d):
        os.makedirs(nice_d)

def parse_xp(tokens):

    # Brute-force parse this out
    timestamp, dm_info = tokens[0].split(']')
    pc, player = tokens[1], tokens[2]
    amt = tokens[3]

    # Clean up
    timestamp = timestamp[1:].strip()
    dm_info = dm_info.split('-')
    dm_event = dm_info[0].strip()
    dm = dm_info[1].split(':')[1].strip()
    pc = pc.split(':')[1].strip()
    player = player.strip()
    amt = int(amt.strip())

    return timestamp, dm_event, dm, pc, player, amt

def do_summary_day(day):

    fname = day + '.log'
    with open(fname, 'w') as f:

        # Put problem cases at the top. See full record for details.
        f.write('EXCESSIVE XP GIVEN\n')
        f.write('==================\n\n')

        for dm in red_flags:
            f.write('DUNGEON MASTER: ' + dm + '\n')
            xp_by_pc = day_rec[dm]

            for entry in xp_by_pc:
                if entry['amt'] > 250:
                    record = '\t{0}({1}): {2}\n'.format(entry['pc'],
                        entry['player'], entry['amt'])
                    f.write(record)
                f.write('\n')

        # General log
        f.write('\n\nDETAILED INFORMATION\n')
        f.write('==================\n\n')

        for dm in day_rec:
            f.write('DUNGEON MASTER: ' + dm + '\n')
            for entry in day_rec[dm]:
                record = '\t{0}({1}): {2}\n'.format(entry['pc'],
                    entry['player'], entry['amt'])
                f.write(record)
                f.write('\tTimeline:\n')
                for timestamp, amt in entry['details']:
                    f.write('\t\t{0} - {1}\n'.format(timestamp, amt))
                f.write('\n')

    # Move file to the appropriate directory.
    old = os.path.join(os.getcwd(), fname)
    new = os.path.join(nice_d, fname)
    if len(red_flags) > 0:
        new = os.path.join(naughty_d, fname)

    os.rename(old, new)

def log_line(timestamp, dm_event, dm, pc, player, amt):

    # First XP giving for this DM today.
    if dm not in day_rec:
        day_rec[dm] = []

    # First entry for this PC given XP by this DM.
    if not any(x['pc'] == pc for x in day_rec[dm]):
        pc_rec = {
                'pc'    : pc,
                'player'  : player,
                'amt'     : amt,
                'details' : [
                    (timestamp, amt)
                    ]
                }
        day_rec[dm].append(pc_rec)

        if amt > 250:
            red_flags.append(dm)

    else:
        pc_idx = next(idx for (idx, d) in enumerate(day_rec[dm]) if d['pc'] == pc)
        day_rec[dm][pc_idx]['amt'] += amt
        day_rec[dm][pc_idx]['details'].append((timestamp, amt))

        if day_rec[dm][pc_idx] > 250 and dm not in red_flags:
            red_flags.append(dm)


setup_dirs()

for line in tailer.follow(open('samplelog.txt')):

    #TODO: Better line validation. We don't want to try to parse
    # any non-XP entries (for now.)
    # Ignore an empty line rather than continuing
    if len(line) < 1:
        continue

    tokens = line.split('|')

    # Ignore if this isn't one of our special lines
    if len(tokens[0].split(']')) < 2:
        continue

    timestamp, dm_event, dm, pc, player, amt = parse_xp(tokens)
    _ = timestamp.split(' ')
    day = _[1] + _[2]

    if curr_day == '':
        # Fresh run, start a new day.
        curr_day = day
    elif curr_day != day:
        # Just hit a new day timestamp - make a record for the last one.

        do_summary_day(curr_day)
        day_rec = {}
        red_flags = []
        curr_day = day

    log_line(timestamp, dm_event, dm, pc, player, amt)

    #TODO: write to a json file too so we have it

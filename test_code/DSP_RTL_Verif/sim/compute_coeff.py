
# Very simple module to calculate S parameters from a, n phasors. 


def compute_coeff(a_amp, a_phase, b_amp, b_phase):
    amp = b_amp/a_amp

    if (b_phase > a_phase):
        phase = b_phase - a_phase_
    else:
        phase = 65535 - abs(b_phase-a_phase)

    return [amp, phase]

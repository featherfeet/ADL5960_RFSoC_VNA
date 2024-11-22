
# Takes in 16 bit input and produces 16 bit output. Internal calculation done with 32 bit fixed point (16 bits past decimal) in RTL. Doing 64 bit calcs here because it's python's default
import math

atan_table = [round(math.degrees(math.atan(2**-i))/360 * 65535) for i in range(15)]
K = 1.64676 #This is the precision we'd have for 16 bit floating point

def do_cordic(x, y):
    x = int(x)
    y = int(y)
    z = 0
    neg_x = False
    neg_y = False

    if (x < 0):
        x = -x
        neg_x = True
    if(y < 0):
        y = -y
        neg_y = True

    if(x == 0 and y == 0):
        return (0, 0)

    for i in range(15): #Diminishing returns after 15 rounds with our precision
        if(y > 0):
            d = 1
        else:
            d = -1

        x_next = x + d * (2**-i) * y
        y_next = y - d * (2**-i) * x
        z_next = z + d * atan_table[i]

        x = x_next
        y = y_next
        z = z_next
        #print("z next : ", z_next, " y next: ", y_next*2**16, " x next: ", x_next*2**16)

    r = int(x/K) 

    if (not neg_x and not neg_y):
        theta = z
    elif (neg_x and not neg_y):
        theta = 32768 - z
    elif(neg_x and neg_y):
        theta = 32768 + z
    else:
        theta = 65535 - z

    return (r, theta)

if __name__ == "__main__":
    print(atan_table)
    print("-3, 4", do_cordic(-3, 4))  
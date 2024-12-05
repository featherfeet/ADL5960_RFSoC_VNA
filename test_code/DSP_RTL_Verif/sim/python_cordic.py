
import math

atan_table = [math.atan(2**-i) for i in range(20)]
K = 1.6467602581221

def do_cordic(x, y):
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

    for i in range(20):
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

    r = x/K

    if (not neg_x and not neg_y):
        theta = z
    elif (neg_x and not neg_y):
        theta = 3.1415 - z
    elif(neg_x and neg_y):
        theta = 3.1415 + z
    else:
        theta = 6.283 - z

    return (r, theta)

if __name__ == "__main__":
    print(atan_table)
    print("-4, -3: ", do_cordic(-4, -3))        






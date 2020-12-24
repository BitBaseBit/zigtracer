const std    = @import("std");
const math   = std.math;
const random = std.Rand.random;

pub fn Vec3(comptime T: type) type {
    return packed struct {
        const Self = @This();

        x: T,
        y: T,
        z: T,

        pub fn new(x: T, y: T, z: T) Self {
            return Self{
                .x = x,
                .y = y,
                .z = z,
            };
        }

        pub fn zero() Self {
            return Self{
                .x = 0,
                .y = 0,
                .z = 0,
            };
        }
        
        pub fn one() Self {
            return Self{
                .x = 1,
                .y = 1,
                .z = 1,
            };
        }

        pub fn add(a: Self, b: Self) Self {
            return Self{
                .x = a.x + b.x,
                .y = a.y + b.y,
                .z = a.z + b.z,
            };
        }

        pub fn sub(a: Self, b: Self) Self {
            return Self{
                .x = a.x - b.x,
                .y = a.y - b.y,
                .z = a.z - b.z,
            };
        }

        pub fn mul(a: Self, s: T) Self {
            return Self{
                .x = a.x * s,
                .x = a.y * s,
                .x = a.z * s,
            };
        }

        pub fn elemWiseMul(lhs: Self, rhs: Self) Self {
            return Self{
                .x = lhs.x * rhs.x,
                .y = lhs.y * rhs.y,
                .z = lhs.z * rhs.z,
            };
        }

        pub fn length(self: Self) T  {
            return math.sqrt(self.x*self.x + self.y*self.y + self.z * self.z);
        }
        
        pub fn lengthSquared(self: Self) T  {
            return self.x*self.x + self.y*self.y + self.z * self.z;
        }

        pub fn dot(a: Self, b: Self) T {
            return a.x * b.x + a.y * b.y + a.z * b.z;
        }
        
        pub fn cross(a: Self, b: Self) Self {
            return Self{
                .x = a.y * b.z - a.z * b.y,
                .y = a.z * b.x - a.x * b.z,
                .z = a.x * b.y - a.y * b.x,
            };
        }

        pub fn makeUnitVector(self: Self) Self {
            const inv_n = 1.0 / self.length();
            return Self{
                .x = inv_n * self.x,
                .y = inv_n * self.y,
                .z = inv_n * self.z,
            };
        }

        pub fn randomInUnitSphere(r: *Random) Self {
            return while (true) {
                const p = Vec3f.new(r.float(f32), r.float(f32), r.float(f32));
                if (p.lengthSquared() < 1.0) {
                    break p;
                }
                // WTF, why do we need an else for a while loop? O.o
            } else Vec3f.zero();
        }

        pub fn randomInUnitDisk(r: *Random) Self {
            return while (true) {
                const p = Vec3f.new(2.0 * r.float(f32) - 1.0, 2.0 * r.float(f32) - 1.0, 0.0);
                if (p.lengthSquared() < 1.0) {
                    break p;
                }
            } else Vec3f.zero();
        }

        pub fn reflect(self: Self, n: Self) Self {
            return self.sub(n.mul(2.0 * self.dot(n)));
        }
    };
}

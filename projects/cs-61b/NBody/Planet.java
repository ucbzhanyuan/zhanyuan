public class Planet {
	public static final double G = 6.67 * 1e-11;
	public double xxPos;
	public double yyPos;
	public double xxVel;
	public double yyVel;
	public double mass;
	public String imgFileName;

	public void draw() {
		StdDraw.picture(xxPos, yyPos, "images\\" + imgFileName);
	}

	public Planet(double xP, double yP, double xV,
		          double yV, double m, String img) {
		xxPos = xP;
		yyPos = yP;
		xxVel = xV;
		yyVel = yV;
		mass = m;
		imgFileName = img;
	}

	public Planet(Planet p) {
		xxPos = p.xxPos;
		yyPos = p.yyPos;
		xxVel = p.xxVel;
		yyVel = p.yyVel;
		mass = p.mass;
		imgFileName = p.imgFileName;
	}

	public double calcDistance(Planet p) {
		double dxSquare = Math.pow(p.xxPos - this.xxPos, 2);
		double dySquare = Math.pow(p.yyPos - this.yyPos, 2);
		double r = Math.sqrt(dxSquare + dySquare);
		return r;
	}

	public double calcForceExertedBy(Planet p) {
		double r = this.calcDistance(p);
		double F = G * this.mass * p.mass / Math.pow(r, 2);
		return F;
	}

	public double calcForceExertedByX(Planet p) {
		double F = this.calcForceExertedBy(p);
		double dx = p.xxPos - this.xxPos;
		double r = this.calcDistance(p);
		double Fx = F * dx / r;
		return Fx;
	}

	public double calcForceExertedByY(Planet p) {
		double F = this.calcForceExertedBy(p);
		double dy = p.yyPos - this.yyPos;
		double r = this.calcDistance(p);
		double Fy = F * dy / r;
		return Fy;
	}

	public double calcNetForceExertedByX(Planet[] allPlanets) {
		double Fnetx = 0;
		for (Planet p: allPlanets) {
			if (p.equals(this)) {
				continue;
			}
			double Fx = this.calcForceExertedByX(p);
			Fnetx += Fx;
		}
		return Fnetx;
	}

	public double calcNetForceExertedByY(Planet[] allPlanets) {
		double Fnety = 0;
		for (Planet p: allPlanets) {
			if (p.equals(this)) {
				continue;
			}
			double Fy = this.calcForceExertedByY(p);
			Fnety += Fy;
		}
		return Fnety;
	}

	public void update(double dt, double fX, double fY) {
		double aNetx = fX / mass;
		double aNety = fY / mass;
		xxVel += aNetx * dt;
		yyVel += aNety * dt;
		xxPos += xxVel * dt;
		yyPos += yyVel * dt;
	}

}
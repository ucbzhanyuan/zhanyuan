public class NBody {
	public static double readRadius(String file) {
		In in = new In(file);
		in.readInt();
		double radius = in.readDouble();
		return radius;
	}

	public static Planet[] readPlanets(String file) {
		In in = new In(file);
		int N = in.readInt();
		Planet[] allplanets = new Planet[N];
		double radius = in.readDouble();
		int i = 0;
		while (i < N) {
			double xP = in.readDouble();
			double yP = in.readDouble();
			double xV = in.readDouble();
			double yV = in.readDouble();
			double m = in.readDouble();
			String img = in.readString();
			allplanets[i] = new Planet(xP, yP, xV, yV, m, img);
			i += 1;
		}
		return allplanets;
	}

	public static void main(String[] args) {
		/** Collecting all needed inputs */
		double T = Double.parseDouble(args[0]);
		double dt = Double.parseDouble(args[1]);
		String filename = args[2];
		double radius = readRadius(filename);
		Planet[] allplanets = readPlanets(filename);

		/** Sets up the universe so that it match the radius */
		StdDraw.setScale(-radius, radius);

		/* Clears the drawing window. */
		StdDraw.clear();

		/** Draws the background */
		StdDraw.picture(0, 0, "images/starfield.jpg", 2*radius, 2*radius);
		StdDraw.show();

		/** Draws all planets */
		for (Planet p: allplanets) {
			p.draw();
			StdDraw.show();
		}

		/** Enables double buffering */
		StdDraw.enableDoubleBuffering();

		int t = 0;
		int N = allplanets.length;
		while (t <= T) {
			/** Create an xForces array and yForces array. */
			double[] xForces = new double[N];
			double[] yForces = new double[N];
			int i = 0;

			/** Calculate the net x and y forces for each planet, 
			    storing these in the xForces and yForces arrays respectively. */
			for (Planet p: allplanets) {
				xForces[i] = p.calcNetForceExertedByX(allplanets);
				yForces[i] = p.calcNetForceExertedByY(allplanets);
				i += 1;
			}

			/** Call update on each of the planets. This will update 
			    each planet’s position, velocity, and acceleration. */
			int k = 0;
			for (Planet p: allplanets) {
				p.update(dt, xForces[k], yForces[k]);
				k += 1;
			}

			/** Draw the background image. */
			StdDraw.picture(0, 0, "images/starfield.jpg", 2*radius, 2*radius);

			/** Draws all planets */
			for (Planet p: allplanets) {
				p.draw();
				StdDraw.show();
			}

			/** Show the offscreen buffer */
			StdDraw.show();

			/** Pause the animation for 10 milliseconds */
			StdDraw.pause(10);

			/** Increase the time variable by dt */
			t += dt;
		}
	}
}
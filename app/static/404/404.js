    /**
     * The stars in our starfield!
     * Stars coordinate system is relative to the CENTER of the canvas
     * @param  {number} x
     * @param  {number} y
     */
    var Star = function(x, y, maxSpeed) {
        this.x = x;
        this.y = y;
        this.slope = y / x; // This only works because our origin is always (0,0)
        this.opacity = 0;
        this.speed = Math.max(Math.random() * maxSpeed, 1);
    };

    /**
     * Compute the distance of this star relative to any other point in space.
     *
     * @param  {int} originX
     * @param  {int} originY
     *
     * @return {float} The distance of this star to the given origin
     */
    Star.prototype.distanceTo = function(originX, originY) {
        return Math.sqrt(Math.pow(originX - this.x, 2) + Math.pow(originY - this.y, 2));
    };

    /**
     * Reinitializes this star's attributes, without re-creating it
     *
     * @param  {number} x
     * @param  {number} y
     *
     * @return {Star} this star
     */
    Star.prototype.resetPosition = function(x, y, maxSpeed) {
        Star.apply(this, arguments);
        return this;
    };

    /**
     * The BigBang factory creates stars (Should be called StarFactory, but that is
     * a WAY LESS COOL NAME!
     * @type {Object}
     */
    var BigBang = {
        /**
         * Returns a random star within a region of the space.
         *
         * @param  {number} minX minimum X coordinate of the region
         * @param  {number} minY minimum Y coordinate of the region
         * @param  {number} maxX maximum X coordinate of the region
         * @param  {number} maxY maximum Y coordinate of the region
         *
         * @return {Star} The random star
         */
        getRandomStar: function(minX, minY, maxX, maxY, maxSpeed) {
            var coords = BigBang.getRandomPosition(minX, minY, maxX, maxY);
            return new Star(coords.x, coords.y, maxSpeed);
        },

        /**
         * Gets a random (x,y) position within a bounding box
         *
         *
         * @param  {number} minX minimum X coordinate of the region
         * @param  {number} minY minimum Y coordinate of the region
         * @param  {number} maxX maximum X coordinate of the region
         * @param  {number} maxY maximum Y coordinate of the region
         *
         * @return {Object} An object with random {x, y} positions
         */
        getRandomPosition: function(minX, minY, maxX, maxY) {
            return {
                x: Math.floor((Math.random() * maxX) + minX),
                y: Math.floor((Math.random() * maxY) + minY)
            };
        }
    };

    /**
     * Constructor function of our starfield. This just prepares the DOM nodes where
     * the scene will be rendered.
     *
     * @param {string} canvasId The DOM Id of the <div> containing a <canvas> tag
     */
    var StarField = function(containerId) {
        this.container = document.getElementById(containerId);
        this.canvasElem = this.container.getElementsByTagName('canvas')[0];
        this.canvas = this.canvasElem.getContext('2d');

        this.width = this.container.offsetWidth;
        this.height = this.container.offsetHeight;

        this.starField = [];
    };

    /**
     * Updates the properties for every star for the next frame to be rendered
     */
    StarField.prototype._updateStarField = function() {
        var i,
            star,
            randomLoc,
            increment;

        for (i = 0; i < this.numStars; i++) {
            star = this.starField[i];

            increment = Math.min(star.speed, Math.abs(star.speed / star.slope));
            star.x += (star.x > 0) ? increment : -increment;
            star.y = star.slope * star.x;

            star.opacity += star.speed / 100;

            // Recycle star obj if it goes out of the frame
            if ((Math.abs(star.x) > this.width / 2) ||
                (Math.abs(star.y) > this.height / 2)) {
                //randomLoc = BigBang.getRandomPosition(
                //    -this.width / 2, -this.height / 2,
                //       this.width, this.height
                //);
                randomLoc = BigBang.getRandomPosition(
                    -this.width / 10, -this.height / 10,
                       this.width / 5, this.height / 5
                );
                star.resetPosition(randomLoc.x, randomLoc.y, this.maxStarSpeed);
            }
        }
    };

    /**
     * Renders the whole starfield (background + stars)
     * This method could be made more efficient by just blipping each star,
     * and not redrawing the whole frame
     */
    StarField.prototype._renderStarField = function() {
        var i,
            star;
        // Background
        this.canvas.fillStyle = "rgba(0, 0, 0, .5)";
        this.canvas.fillRect(0, 0, this.width, this.height);
        // Stars
        for (i = 0; i < this.numStars; i++) {
            star = this.starField[i];
            this.canvas.fillStyle = "rgba(188, 213, 236, " + star.opacity + ")";
            this.canvas.fillRect(
                star.x + this.width / 2,
                star.y + this.height / 2,
                2, 2);
        }
    };

    /**
     * Function that handles the animation of each frame. Update the starfield
     * positions and re-render
     */
    StarField.prototype._renderFrame = function(elapsedTime) {
        var timeSinceLastFrame = elapsedTime - (this.prevFrameTime || 0);

        window.requestAnimationFrame(this._renderFrame.bind(this));

        // Skip frames unless at least 30ms have passed since the last one
        // (Cap to ~30fps)
        if (timeSinceLastFrame >= 30 || !this.prevFrameTime) {
            this.prevFrameTime = elapsedTime;
            this._updateStarField();
            this._renderStarField();
        }
    };

    /**
     * Makes sure that the canvas size fits the size of its container
     */
    StarField.prototype._adjustCanvasSize = function(width, height) {
        // Set the canvas size to match the container ID (and cache values)
        this.width = this.canvasElem.width = width || this.container.offsetWidth;
        this.height = this.canvasElem.height = height || this.container.offsetHeight;
    };

    /**
     * This listener compares the old container size with the new one, and caches
     * the new values.
     */
    StarField.prototype._watchCanvasSize = function(elapsedTime) {
        var timeSinceLastCheck = elapsedTime - (this.prevCheckTime || 0),
            width,
            height;

        window.requestAnimationFrame(this._watchCanvasSize.bind(this));

        // Skip frames unless at least 333ms have passed since the last check
        // (Cap to ~3fps)
        if (timeSinceLastCheck >= 333 || !this.prevCheckTime) {
            this.prevCheckTime = elapsedTime;
            width = this.container.offsetWidth;
            height = this.container.offsetHeight;
            if (this.oldWidth !== width || this.oldHeight !== height) {
                this.oldWidth = width;
                this.oldHeight = height;
                this._adjustCanvasSize(width, height);
            }
        }
    };

    /**
     * Initializes the scene by resizing the canvas to the appropiate value, and
     * sets up the main loop.
     * @param {int} numStars Number of stars in our starfield
     */
    StarField.prototype._initScene = function(numStars) {
        var i;
        for (i = 0; i < this.numStars; i++) {
            this.starField.push(
                BigBang.getRandomStar(-this.width / 2, -this.height / 2, this.width, this.height, this.maxStarSpeed)
            );
        }

        // Intervals not stored because I don't plan to detach them later...
        window.requestAnimationFrame(this._renderFrame.bind(this));
        window.requestAnimationFrame(this._watchCanvasSize.bind(this));
    };

    /**
     * Kicks off everything!
     * @param {int} numStars The number of stars to render
     * @param {int} maxStarSpeed Maximum speed of the stars (pixels / frame)
     */
    StarField.prototype.render = function(numStars, maxStarSpeed) {
        this.numStars = numStars || 100;
        this.maxStarSpeed = maxStarSpeed || 3;

        this._initScene(this.numStars);
    };

    /**
     * requestAnimationFrame shim layer with setTimeout fallback
     * @see http://paulirish.com/2011/requestanimationframe-for-smart-animating
     */
    (function() {
        var lastTime = 0;
        var vendors = ['ms', 'moz', 'webkit', 'o'];
        for(var x = 0; x < vendors.length && !window.requestAnimationFrame; ++x) {
            window.requestAnimationFrame = window[vendors[x]+'RequestAnimationFrame'];
            window.cancelAnimationFrame =
              window[vendors[x]+'CancelAnimationFrame'] || window[vendors[x]+'CancelRequestAnimationFrame'];
        }

        if (!window.requestAnimationFrame)
            window.requestAnimationFrame = function(callback, element) {
                var currTime = new Date().getTime();
                var timeToCall = Math.max(0, 16 - (currTime - lastTime));
                var id = window.setTimeout(function() { callback(currTime + timeToCall); },
                  timeToCall);
                lastTime = currTime + timeToCall;
                return id;
            };

        if (!window.cancelAnimationFrame)
            window.cancelAnimationFrame = function(id) {
                clearTimeout(id);
            };
    }());

    // Kick off!
    var starField = new StarField('fullScreen').render(333, 3);
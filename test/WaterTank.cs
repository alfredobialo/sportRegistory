using System;

namespace test
{
    public delegate void WaterTankCapacityHandler(object o, WaterTankCapacityEventArg e);
    public class WaterTank
    {
        public event WaterTankCapacityHandler CapacityChanged;
        public WaterTank()
        {
            Capacity = 250; //litres

        }
        private double capacity;

        public double Capacity
        {
            get { return capacity; }
            set
            {

                capacity = value;
                // Raise the event
                OnCapacityChange(new WaterTankCapacityEventArg(capacity));
            }
        }

        protected virtual void OnCapacityChange(WaterTankCapacityEventArg e)
        {
            if (CapacityChanged != null)
            {
                CapacityChanged(this, e);
            }
        }
    }


    public class WaterTankCapacityEventArg : EventArgs
    {
        public WaterTankCapacityEventArg(double capacity)
        {
            Capacity = capacity;
        }
        public double Capacity { get; internal set; }

    }
}

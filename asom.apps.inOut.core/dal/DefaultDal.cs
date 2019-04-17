using itrex.businessObjects.model.core;

namespace asom.apps.inOut.core.dal
{
    public abstract class DefaultDal<T>  : DefRepository<T>
    {
        protected abstract void Save();
    }
}

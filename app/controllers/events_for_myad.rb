module EventsForMyad
  def fresh
    @myad.fresh
    respond_to do |format|
      format.html { redirect_to myads_path }
    end
  end

  def reject
    @myad.reject
    respond_to do |format|
      format.html { redirect_to myads_path }
    end
  end

  def approve
    @myad.approve
    respond_to do |format|
      format.html { redirect_to myads_path }
    end
  end

  def publish
    @myad.publish
    respond_to do |format|
      format.html { redirect_to myads_path }
    end
  end

  def archive
    @myad.archive
    respond_to do |format|
      format.html { redirect_to myads_path }
    end
  end
  
  def ban
    @myad.ban
    respond_to do |format|
      format.html { redirect_to myads_path }
    end
  end

  def draft
    @myad.draft
    respond_to do |format|
      format.html { redirect_to myads_path }
    end
  end
end
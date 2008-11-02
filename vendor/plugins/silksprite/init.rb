# Make helper available in views.
ActionController::Base.helper SilkspriteHelper
ActionView::Base.send(:include, Silksprite::IncludesHelper)